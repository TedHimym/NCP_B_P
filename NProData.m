
classdef NProData < handle
    %用于圆柱自然对流模型的数据分析
    %   记录数据文件保存的位置、时间步长和数据文件输出间隔
    %   可以进行画图分析等操作
    
    properties
        TotolTime;                  %总时间
        Path = './';                %文件路径
        NamePro = 'fluentTS-';      %文件前缀
        DataFileList;               %数据文件名列表，为cell列表
        TimeList;                   %数据文件对应时间，为向量
        FileNumber = 0;             %数据文件的个数，被GetDataFileNumber()函数初始化
        time;
        Tx = 0.6;
        dataV;
    end
    
    methods
        %分析得到的数据文件的个数
        function num = GetDataFileNumber(obj)
            fileList = dir(obj.Path); num = 0;
            for fileCell = {fileList.name}
                filename = fileCell{1};
                if(strcmp(filename(1:min(size(obj.NamePro,2),length(filename))), obj.NamePro))
                    num = num + 1;
                end
            end
        end
        %通过指定的时间计算对应的数据文件并读取到Data
        function Data = GetData(obj, time)
            if obj.time == time
                Data = obj.dataV;
            else
                obj.time = time;
                TimeR = max(obj.TimeList((obj.time - obj.TimeList)>=0));
                TimeL = min(obj.TimeList((obj.time - obj.TimeList) <0));
                if (~size(TimeL, 1))
                    try
                        File = importdata([obj.Path obj.DataFileList{obj.TimeList==TimeR}]);
                    catch
                        disp([obj.Path obj.DataFileList{obj.TimeList==TimeR}])
                    end
                    try
                        obj.dataV = File.data;
                        Data = obj.dataV;
                    catch
                        disp('break')
                    end
                else
                    weightR = (obj.time - TimeL) / (TimeR - TimeL);
                    weightL = (TimeR - obj.time) / (TimeR - TimeL);
                    FileR = importdata([obj.Path obj.DataFileList{obj.TimeList==TimeR}]);
                    FileL = importdata([obj.Path obj.DataFileList{obj.TimeList==TimeL}]);
                    try
                    obj.dataV = weightL * FileL.data + weightR * FileR.data;
                    catch
                        disp('debug')
                    end
                    Data = obj.dataV;
                end
            end
        end
        %通过指定时间指定高度与半径得到速度与温度的数据
        function varargout = GetData_Pos(obj, h, r, time, type)
            if (isequal('av', type))
                index = 4;
            elseif (isequal('rv', type))
                index = 5;
            elseif (isequal('T', type))
                index = 6;
            else
                exit()
            end
            data = obj.GetData(time);
            if (isa(r, 'char') && isa(h, 'double'))
                r = unique(data(:,3));
                r = r(2:end);
            elseif (isa(r, 'double') && isa(h, 'char'))
                h = unique(data(:,2));
            elseif (isa(r, 'double') && isa(h, 'double'))
                
            elseif (isa(r, 'char') && isa(h, 'char'))
                r = unique(data(:,3));
                r = r(2:end);
                h = unique(data(:,2))';
            end
            [H, R, D] = griddata(data(:,2), data(:,3), data(:,index), h, r, 'linear');
            if (nargout == 1)
                varargout{1} = [H R D];
            elseif (nargout == 2)
                varargout{1} = R;
                varargout{2} = D;
            elseif (nargout == 3)
                varargout{1} = H;
                varargout{2} = R;
                varargout{3} = D;
            end
        end
        %通过指定边界层厚度和高度与时间得到温度和对应的半径
        function [R, F] = T_r(obj, h, delta, time)
            [~, R, T] = obj.GetData_Pos(h, 'r', time, 'T');
            indexR = (R==min(R(R>delta+R(1))));
            indexL = (R==max(R(R<delta+R(1))));
            ER = delta+R(1);
            ET = interp1([R(indexL) R(indexR)], [T(indexL) T(indexR)], ER, 'linear');
            F = ([T(R<ER); ET]);
            R = [R(R<ER); ER];
        end
        %通过指定边界层厚度和高度与时间得到速度和对应的半径
        function [InteR, Intef] = U_r(obj, h, delta, time)
            [~, R, T] = obj.GetData_Pos(h, 'r', time, 'av');
            indexR = (R==min(R(R>delta+R(1))));
            indexL = (R==max(R(R<delta+R(1))));
            ER = delta+R(1);
            ET = interp1([R(indexL) R(indexR)], [T(indexL) T(indexR)], ER, 'linear');
            Intef = ([T(R<ER); ET]);
            InteR = [R(R<ER); ER];
        end
        %温度边界层厚度
        function varargout = TBL_TR(obj, h, time)
            ER = zeros(1, length(h));
            TT = zeros(1, length(h));
            for index = 1:length(h)
                [~, R, T] = obj.GetData_Pos(h(index), 'r', time, 'T');
                ER(index) = min(T) + (max(T)-min(T))*obj.Tx;
                indexR=(T==min(T(T>ER(index))));
                indexL=(T==max(T(T<ER(index))));
                ER(index) = interp1([T(indexL) T(indexR)], [R(indexL) R(indexR)], ER(index), 'linear');
                TT(index) = ER(index) - min(R);
                if (nargout == 0)
                    varargout{1} = [TT, ER];
                elseif (nargout == 1)
                    varargout{1} = TT;
                elseif (nargout == 2)
                    varargout{1} = TT;
                    varargout{2} = ER;
                end
            end
        end
        %速度边界层厚度
        function [VT, ER] = VBL_TR(obj, h, time)
            ER = zeros(1, length(h));
            VT = zeros(1, length(h));
            for index = 1:length(h)
                [~, R, V] = obj.GetData_Pos(h(index), 'r', time, 'av');
                V = V(R>R(V==min(V)));
                R = R(R>R(V==min(V)));
                ER(index) = min(V) * 0.01;
                indexR=(V==min(V(V>ER(index))));
                indexL=(V==max(V(V<ER(index))));
                ER(index) = interp1([V(indexL) V(indexR)], [R(indexL) R(indexR)], ER(index), 'linear');
                VT(index) = ER(index) - min(R);
            end
        end
        %得到特征速度
        function [mU, r] = getmU(obj,h,time)
            [~,R,U] = obj.GetData_Pos(h, 'r', time, 'av');
            mU = max(abs(U));
            r = R(abs(U)==mU);
        end
        %截面上的场分布
        function [X, Y, Z] = Surface(obj, time, type)
            if (isequal('T', type))
                index = 6;
            elseif (isequal('av', type))
                index = 4;
            elseif (isequal('rv', type))
                index = 5;
            end
            data = obj.GetData(time);
            r = unique(data(:,3));
            h = unique(data(:,2));
            [X, Y, Z] = griddata(data(:,2), data(:,3), data(:,index), h', r, 'linear');
            figure
            surf(X, Y, Z)
        end
        
        %初始化类函数
        function obj = NProData(Path, NamePro, varargin)
            if (nargin == 3)
                obj.time = varargin{1};
            end
            obj.time = 0;
            obj.dataV = 0;
            obj.Path = Path;
            obj.NamePro = NamePro;
            obj.FileNumber = obj.GetDataFileNumber();
            obj.DataFileList = cell(obj.FileNumber,1);
            obj.TimeList = zeros(obj.FileNumber,1);
            index = 1;
            filelist = dir(obj.Path);
            for fileCell = {filelist.name}
                filename = fileCell{1};
                if(strcmp(filename(1:min(size(NamePro,2),length(filename))), NamePro))
                    obj.TimeList(index) = str2double(filename(size(NamePro,2)+1:end));
                    obj.DataFileList{index} = filename;
                    index = index+1;
                end
            end
            obj.TotolTime = max(obj.TimeList);
        end
    end
    
    methods(Static)
% 
    end
end

