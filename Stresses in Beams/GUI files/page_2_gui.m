function varargout = page_2_gui(varargin)
% PAGE_2_GUI MATLAB code for page_2_gui.fig
%      PAGE_2_GUI, by itself, creates a new PAGE_2_GUI or raises the existing
%      singleton*.
%
%      H = PAGE_2_GUI returns the handle to a new PAGE_2_GUI or the handle to
%      the existing singleton*.
%
%      PAGE_2_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAGE_2_GUI.M with the given input arguments.
%
%      PAGE_2_GUI('Property','Value',...) creates a new PAGE_2_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before page_2_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to page_2_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help page_2_gui

% Last Modified by GUIDE v2.5 11-Nov-2017 01:25:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @page_2_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @page_2_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before page_2_gui is made visible.
function page_2_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to page_2_gui (see VARARGIN)

% Choose default command line output for page_2_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes page_2_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Generating the intial view for the window by disabling unnecessary edit,text fields and pushbuttons
handle1_array=[handles.text_input_Mx, handles.text_input_My, handles.edit_input_Mx, handles.edit_input_My, handles.pushbutton_submit...
    ,handles.pushbutton_next];
set(handle1_array,'Enable','off');

% --- Outputs from this function are returned to the command line.
function varargout = page_2_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'Click to input moment values'. Following
%code executes after pressing above button. It initializes the page by taking up the parameters 'a,b,c,d,x,y' stored in the root
%file by page 1(input page).Through the parameters and the case of selected
%cross section, it sets in the vectors plot_x and plot_y to be used for showing the image of cross-section and principle axes 
 handle1_array=[handles.text_input_Mx, handles.text_input_My, handles.edit_input_Mx, handles.edit_input_My,handles.pushbutton_submit];
 set(handle1_array,'Enable','on');
 a=getappdata(0,'a'); b=getappdata(0,'b'); c=getappdata(0,'c'); d=getappdata(0,'d');e=(a-d)/2;...
 x_array=getappdata(0,'x'); y_array=getappdata(0,'y');
 crosssection=getappdata(0,'crosssection'); % case of selected cross-section
 plot_x=[];   %vectors containing the vertices of convex polygon enetred as input 
 plot_y=[];   % also used for plotting
 x1=0;
 y1=0;
 switch crosssection
     case 1  %rectangular case
        plot_x = [x1 x1+a x1+a  x1  x1];
        plot_y = [y1  y1  y1+b y1+b y1];
     case 2 %triangular case
        plot_x = [x1 x1+a x1+a/2 x1 ];
        plot_y = [y1 y1 y1+b y1]; 
     case 3  %I shaped
        plot_x = [x1 x1+a  x1+a  x1+a-e  x1+a-e   x1+a    x1+a     x1       x1    x1+e  x1+e x1   x1 ];  % x coordinates (anticlockwise)
        plot_y = [y1  y1   y1+b  y1+b    y1+b+c  y1+b+c y1+b+c+b y1+b+c+b y1+b+c y1+b+c y1+b y1+b y1 ];  % x coordinates (anticlockwise)
     case 4  %L shaped
        plot_x = [x1 x1+a  x1+a  x1+b  x1+b   x1  x1 ];
        plot_y = [y1  y1   y1+b  y1+b  y1+c  y1+c y1 ]; 
     case 5  %arbitrary cross-section
        plot_x = [x_array x_array(1)];
        plot_y = [y_array y_array(1)];
     otherwise
 end

 
 % retrieving geometrical values and plotting
 
 [geom,iner,cpmo,eig_vec, xm, ym ]=polygeom(plot_x,plot_y); %using the function polygeom(included in the base code),geometrical 
 X_C=geom(2);   % x coordinate of centroid                  %parameters like centroid, moments of inertias are retrieved
 Y_C=geom(3);   % y coordinate of centroid
 ang1=cpmo(2); ang2=cpmo(4);

 x_mag=max(plot_x)-min(plot_x);
 y_mag=max(plot_y)-min(plot_y);
 principle_axes_mag=max(x_mag,y_mag);
 
 % creating vectors (Mx_vec and My_vec) to be used for plotting the priciple axes
 x_principle_1 = [ X_C-principle_axes_mag*cos(ang1)  X_C+principle_axes_mag*cos(ang1) ];  
 y_principle_1 = [ Y_C-principle_axes_mag*sin(ang1)  Y_C+principle_axes_mag*sin(ang1) ];  
 
 x_principle_2 = [ X_C-principle_axes_mag*cos(ang2)  X_C+principle_axes_mag*cos(ang2) ];  
 y_principle_2 = [ Y_C-principle_axes_mag*sin(ang2)  Y_C+principle_axes_mag*sin(ang2) ];  
 
 Mx_vec = [principle_axes_mag*cos(ang1)/2 principle_axes_mag*sin(ang1)/2];
 My_vec = [principle_axes_mag*cos(ang2)/2 principle_axes_mag*sin(ang2)/2];
 
 %storing vectors used for plotting principle axes in the root directory(to be used in page_3)
 setappdata(0,'Mx_vec',Mx_vec);  
 setappdata(0,'My_vec',My_vec);
 setappdata(0,'X_C',X_C);        
 setappdata(0,'Y_C',Y_C);
 setappdata(0,'plot_x',plot_x);
 setappdata(0,'plot_y',plot_y);
 setappdata(0,'x_principle_1',x_principle_1);
 setappdata(0,'y_principle_1',y_principle_1);
 setappdata(0,'x_principle_2',x_principle_2);
 setappdata(0,'y_principle_2',y_principle_2);
 
 %plotting figure of selected cross-section along with the principle axes
 plot(plot_x, plot_y,'b-');
 hold on;
 plot(X_C,Y_C,'ro', x_principle_1,y_principle_1,'k:', x_principle_2,y_principle_2,'k:');
 quiver(X_C,Y_C,Mx_vec(1),Mx_vec(2),'r');
 quiver(X_C,Y_C,My_vec(1),My_vec(2),'r');
 xlabel('x axis');
 ylabel('y axis');
 axis square;


    



function edit_input_Mx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_Mx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_Mx as text
%        str2double(get(hObject,'String')) returns contents of edit_input_Mx as a double


% --- Executes during object creation, after setting all properties.
function edit_input_Mx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_Mx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_My_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_My (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_My as text
%        str2double(get(hObject,'String')) returns contents of edit_input_My as a double

% --- Executes during object creation, after setting all properties.
function edit_input_My_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_My (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_previous.
function pushbutton_previous_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button named 'Previous Page'.Following code runs upon clicking above button.
%This function closes current page(page_2) and opens up page1(input_gui)
close(page_2_gui);
input_gui;


% --- Executes on button press in pushbutton_next.
function pushbutton_next_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button named 'Confirm and go to next page'.Following code runs upon clicking above button.
%saves the value of Mx and My in root directory(to be used in page_3).
%closes current page and opens page_3
Mx=str2num(get(handles.edit_input_Mx,'String'));
My=str2num(get(handles.edit_input_My,'String'));
setappdata(0,'Mx_page3',Mx);
setappdata(0,'My_page3',My);
close(page_2_gui)
page_3_gui;


% --- Executes on button press in pushbutton_submit.
function pushbutton_submit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button named 'submit'.Following code runs upon clicking above button.
%Accepts the user input Mx and My. Disables unnecessary text and edit
%fields. 
Mx=str2num(get(handles.edit_input_Mx,'String'));
My=str2num(get(handles.edit_input_My,'String'));
if ~isempty(Mx)&&~isempty(My)
  setappdata(0,'Mx_page3',Mx);
  setappdata(0,'Mx_page3',My);
  handle1_array=[handles.text_input_Mx, handles.text_input_My, handles.edit_input_Mx, handles.edit_input_My, handles.pushbutton_submit];
  set(handle1_array,'Enable','off');
  set(handles.pushbutton_next,'Enable','on');
end
