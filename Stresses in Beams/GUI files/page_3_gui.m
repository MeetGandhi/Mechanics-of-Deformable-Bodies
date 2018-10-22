function varargout = page_3_gui(varargin)
% PAGE_3_GUI MATLAB code for page_3_gui.fig
%      PAGE_3_GUI, by itself, creates a new PAGE_3_GUI or raises the existing
%      singleton*.
%
%      H = PAGE_3_GUI returns the handle to a new PAGE_3_GUI or the handle to
%      the existing singleton*.
%
%      PAGE_3_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAGE_3_GUI.M with the given input arguments.
%
%      PAGE_3_GUI('Property','Value',...) creates a new PAGE_3_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before page_3_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to page_3_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help page_3_gui

% Last Modified by GUIDE v2.5 12-Nov-2017 18:37:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @page_3_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @page_3_gui_OutputFcn, ...
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


% --- Executes just before page_3_gui is made visible.
function page_3_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to page_3_gui (see VARARGIN)

% Choose default command line output for page_3_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Generating the intial view for the window by disabling unnecessary edit,text fields and pushbuttons
handle2_array = [handles.text_x, handles.text_y, handles.edit_x, handles.edit_y, handles.pushbutton_submit_reenter, handles.edit_value...
    , handles.text_value, handles.pushbutton_complete, handles.pushbutton_point, handles.pushbutton_reenter, handles.text_Mx,...
    handles.text_My, handles.edit_Mx, handles.edit_My, handles.pushbutton_calculate];
set(handle2_array,'Enable','off');
% retreiving key Mx and My stored in root directory and storing as M vector
% to be used in page 3
 Mx=getappdata(0,'Mx_page3');
 My=getappdata(0,'My_page3');
 M=[Mx My];
 setappdata(0,'M',M);


% UIWAIT makes page_3_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = page_3_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_complete.
function pushbutton_complete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_complete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'Complete Stress Distribution'. Following
%code executes after pressing above button. Generates a 3D plot using
%the function 'quiver3' containing the vectors depicting
%nature(tensile/compressive) and magnitude of stress at interior points of polygon 
plot_x=getappdata(0,'plot_x');                                  %receiveing values of plot_x,plot_y and M from the root directory
plot_y=getappdata(0,'plot_y');
M=getappdata(0,'M');
[Stress,grid_x,grid_y] = Stress_calculator(plot_x,plot_y,M);    %calculating stress at decided number of points within the figure
p=size(grid_x,1);                                               %the function being used is Stress_calculator.Input for this function 
q=size(grid_x,2);                                               %are vectors plot_x,plot_y containing vertices of polygon in anticlockwise sense 
% figure;                                                       %and vector M containing components of moment vector in x and y direction
                                                            
                                                                
%plotting vectors for stress values at each decided point
quiver3(grid_x,grid_y,zeros(p,q),zeros(p,q),zeros(p,q),Stress );  %intiates a 3D plot                                                                %section
hold on;
rotate3d on;

plot(plot_x,plot_y,'k-');                %plotting the cross-section in the same figure
xlabel('x axis');
ylabel('y axis');
Mx_vec=getappdata(0,'Mx_vec');
My_vec=getappdata(0,'My_vec');
X_C=getappdata(0,'X_C');
Y_C=getappdata(0,'Y_C');
quiver(X_C,Y_C,Mx_vec(1),Mx_vec(2),'r');   %plotting priciple axes in the same figure
quiver(X_C,Y_C,My_vec(1),My_vec(2),'r');
hold off;

% % Neutral axis
% i=Stress(Stress==0);

% --- Executes on button press in pushbutton_point.
function pushbutton_point_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'Stress at a point'. Following
%code executes after pressing above button. Enables corresponding text and
%edit fields
handle2_array = [handles.text_x, handles.text_y, handles.edit_x, handles.edit_y, handles.pushbutton_calculate, handles.edit_value...
    , handles.text_value];
set(handle2_array,'Enable','on');




function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y as text
%        str2double(get(hObject,'String')) returns contents of edit_y as a double


% --- Executes during object creation, after setting all properties.
function edit_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_value_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value as text
%        str2double(get(hObject,'String')) returns contents of edit_value as a double


% --- Executes during object creation, after setting all properties.
function edit_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_submit_reenter.
function pushbutton_submit_reenter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_submit_reenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'submit'. Following
%code executes after pressing above button. It accepts the input for new Mx and
%My values and updates vector M to be used for calculating Stress at each
%interior point and visualizing
%stress distribution
Mx=str2num(get(handles.edit_Mx,'String'));
My=str2num(get(handles.edit_My,'String'));
M=[Mx My];
setappdata(0,'M',M);
handle_disable_array=[handles.text_Mx, handles.text_My, handles.edit_Mx, handles.edit_My, handles.pushbutton_submit_reenter];
handle_enable_array=[handles.pushbutton_point, handles.pushbutton_complete];
handle_clear_array=[handles.edit_Mx, handles.edit_My];
set(handle_clear_array,'String','');
set(handle_enable_array,'Enable','on');
set(handle_disable_array,'Enable','off');

% S=Stress_point(plot_x,plot_y,[x,y],M);       %The function Stress_point has been made by the coder. It takes input in form of vectors 
% set(handles.edit_value,'String',num2str(S)); %containing vertices of ploygon along with the point at which stress has to be calculated
                                             %and the moment vector


% --- Executes on button press in pushbutton_click.
function pushbutton_click_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_click (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'Click to proceed'. Following
%code executes after pressing above button. Enables pushbuttons
%'Stress at a point' and 'Complete Stress distribution'. Retreives
%parameters 'plot_x,plot_y,X_C,Y_C,Mx_vec,My_vec' etc saved in  the root
%directory and draws the figure showing selected cross-section and
%principle axes
handle_array=[handles.pushbutton_complete, handles.pushbutton_point, handles.pushbutton_reenter];
set(handle_array,'Enable','on');
set(handles.pushbutton_click,'Enable','off');

Mx_vec=getappdata(0,'Mx_vec');  
My_vec=getappdata(0,'My_vec');
X_C=getappdata(0,'X_C');        
Y_C=getappdata(0,'Y_C');
plot_x=getappdata(0,'plot_x');
plot_y=getappdata(0,'plot_y');
x_principle_1=getappdata(0,'x_principle_1');
y_principle_1=getappdata(0,'y_principle_1');
x_principle_2=getappdata(0,'x_principle_2');
y_principle_2=getappdata(0,'y_principle_2');
 
plot(plot_x, plot_y,'b-');
hold on;
plot(X_C,Y_C,'ro', x_principle_1,y_principle_1,'k:', x_principle_2,y_principle_2,'k:');
quiver(X_C,Y_C,Mx_vec(1),Mx_vec(2),'r');
quiver(X_C,Y_C,My_vec(1),My_vec(2),'r');
xlabel('x axis');
ylabel('y axis');
axis square;
hold off;


% --- Executes on button press in pushbutton_page1.
function pushbutton_page1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_page1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'Go to page1'. Following
%code executes after pressing above button.
%closes the current page and opens up page_1(input_gui) 
close(page_3_gui);
input_gui;


% --- Executes on button press in pushbutton_reenter.
function pushbutton_reenter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'Reenter moment values'. Following
%code executes after pressing above button.Enables the edit fields used to
%take inputs for new values of Mx and My along with showing the cross
%section 
handle_disable_array=[handles.pushbutton_point, handles.text_x, handles.text_y, handles.edit_x, handles.edit_y, handles.pushbutton_calculate...
    handles.text_value, handles.edit_value, handles.pushbutton_complete];
handle_enable_array=[handles.text_Mx, handles.text_My, handles.edit_Mx, handles.edit_My, handles.pushbutton_submit_reenter];
handle_clear_array=[handles.edit_x, handles.edit_y,handles.edit_value];
set(handle_disable_array,'Enable','off');
set(handle_enable_array,'Enable','on');
set(handle_clear_array,'String','');

Mx_vec=getappdata(0,'Mx_vec');  
My_vec=getappdata(0,'My_vec');
X_C=getappdata(0,'X_C');        
Y_C=getappdata(0,'Y_C');
plot_x=getappdata(0,'plot_x');
plot_y=getappdata(0,'plot_y');
x_principle_1=getappdata(0,'x_principle_1');
y_principle_1=getappdata(0,'y_principle_1');
x_principle_2=getappdata(0,'x_principle_2');
y_principle_2=getappdata(0,'y_principle_2');
 
plot(plot_x, plot_y,'b-');
hold on;
plot(X_C,Y_C,'ro', x_principle_1,y_principle_1,'k:', x_principle_2,y_principle_2,'k:');
quiver(X_C,Y_C,Mx_vec(1),Mx_vec(2),'r');
quiver(X_C,Y_C,My_vec(1),My_vec(2),'r');
xlabel('x axis');
ylabel('y axis');
axis square;
hold off;




function edit_Mx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Mx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Mx as text
%        str2double(get(hObject,'String')) returns contents of edit_Mx as a double


% --- Executes during object creation, after setting all properties.
function edit_Mx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Mx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_My_Callback(hObject, eventdata, handles)
% hObject    handle to edit_My (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_My as text
%        str2double(get(hObject,'String')) returns contents of edit_My as a double


% --- Executes during object creation, after setting all properties.
function edit_My_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_My (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_reenter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_reenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'calculate'. Following
%code executes after pressing above button. Accepts the input given for
%calculating stress at a point. Retrives parameters such as 'plot_x, plot_y'
%from the root directory and calculates value of stress at the point asked
plot_x=getappdata(0,'plot_x');
plot_y=getappdata(0,'plot_y');
M=getappdata(0,'M');
x=str2num(get(handles.edit_x,'String'));
y=str2num(get(handles.edit_y,'String'));
S=num2str(Stress_point(plot_x,plot_y,[x y],M));
set(handles.edit_value,'String',S);
