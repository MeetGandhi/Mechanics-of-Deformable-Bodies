
function varargout = input_gui(varargin)
% INPUT_GUI MATLAB code for input_gui.fig
%      INPUT_GUI, by itself, creates a new INPUT_GUI or raises the existing
%      singleton*.
%
%      H = INPUT_GUI returns the handle to a new INPUT_GUI or the handle to
%      the existing singleton*.
%
%      INPUT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPUT_GUI.M with the given input arguments.
%
%      INPUT_GUI('Property','Value',...) creates a new INPUT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before input_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to input_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help input_gui

% Last Modified by GUIDE v2.5 12-Nov-2017 22:30:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @input_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @input_gui_OutputFcn, ...
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


% --- Executes just before input_gui is made visible.
function input_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to input_gui (see VARARGIN)


% Choose default command line output for input_gui

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Generating the intial view for the input window by disabling unnecessary edit,text fields and pushbuttons 
new_handle_array=[handles.text_x_array,handles.text_y_array,handles.text_a,handles.text_b,handles.text_c,handles.text_d,handles.text_input,];
set(new_handle_array,'Value',[]);
Base_handle_array=[handles.text_I_a, handles.text_I_b, handles.text_I_c, handles.text_I_d, handles.text_arbit_x...
    ,handles.text_arbit_y, handles.text_arbit_top, handles.edit_I_a, handles.edit_I_b, handles.edit_I_c, handles.edit_I_d...
    ,handles.edit_arbit_x, handles.edit_arbit_y, handles.pushbutton_I_submit, handles.pushbutton_arbit_next, handles.pushbutton_arbit_submit...
    ,handles.pushbutton_reset,handles.pushbutton_nextpage];
set(Base_handle_array,'Enable','off');

% UIWAIT makes input_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = input_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function cr_sec_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cr_sec_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when cr_sec_panel is resized.
function cr_sec_panel_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to cr_sec_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in pop_crosssectiontype.
function pop_crosssectiontype_Callback(hObject, eventdata, handles)
% hObject    handle to pop_crosssectiontype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns pop_crosssectiontype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_crosssectiontype


% --- Executes during object creation, after setting all properties.
function pop_crosssectiontype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_crosssectiontype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_preview.
function pushbutton_preview_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for preview button . It generates the figure showing
%cross-section type
handle_array=[handles.text_I_a, handles.text_I_b, handles.text_I_c, handles.text_I_d, handles.text_arbit_x...
    ,handles.text_arbit_y, handles.text_arbit_top, handles.edit_I_a, handles.edit_I_b, handles.edit_I_c, handles.edit_I_d...
    ,handles.edit_arbit_x, handles.edit_arbit_y, handles.pushbutton_I_submit, handles.pushbutton_arbit_next, handles.pushbutton_arbit_submit];
set(handle_array,'Enable','off');
val2=get(handles.pop_crosssectiontype,'Value');

% plotting the figure showing cross-section type
switch val2
    case 1   % rectangle
        set(handles.text_input,'Value',1);
        a=5;  %width
        b=2;  %height
        x = 4;
        y = 1;
        base_x = [x x+a x+a  x   x];
        base_y = [y  y  y+b y+b y];
        
        plot(base_x, base_y,'-');
        hold on;
        axis([2 a+6 0 b+3]);

        %labelling the figure
        eps_x=0.16; % offset in x
        eps_y=0.12; % offset in y
        text(x+a+eps_x+eps_x+eps_x, y+b/2, 'b','HorizontalAlignment','right');%labelling b
        text(x+a/2, y+b+eps_y+eps_y, 'a','HorizontalAlignment','right');%labelling a
        hold off;
        axis off;

        
    case 2  % Triangle
        set(handles.text_input,'Value',2);
        a=5;  %width
        b=2;  %height
        x = 4;
        y = 1;
        base_x = [x x+a x+a/2 x ];
        base_y = [y y y+b y];
       
        plot(base_x, base_y,'-');
        hold on;
        axis([2 a+6 0 b+3]);
        %labelling the figure
        eps_x=0.16; % offset in x
        eps_y=0.12; % offset in y
        plot([x+(a/2) x+(a/2)],[y y+b],'k:');  % dimension b
        text(x+(a/2)+2.4*eps_x, y+b/2, 'b','HorizontalAlignment','right'); %labelling b
        text(x+a/2, y-eps_y, 'a','HorizontalAlignment','center'); %labelling a
        hold off;
        axis off;

        
    case 3   % I shaped cross-section
        set(handles.text_input,'Value',3);
        a=5;  %width
        b=2;  %height
        c=3;
        d=2;
        e=(a-d)/2;
        x = 4;
        y = 1;
        base_x = [x x+a  x+a  x+a-e  x+a-e   x+a    x+a     x       x    x+e  x+e x   x ];  % x coordinates (anticlockwise)
        base_y = [y  y   y+b  y+b    y+b+c  y+b+c y+b+c+b y+b+c+b y+b+c y+b+c y+b y+b y ];  % x coordinates (anticlockwise)
        plot(base_x, base_y,'-');
        hold on;
        % Axes properties
        hor_scale = a+8;
        ver_scale = b+b+c+3;
        axis([0 hor_scale 0 ver_scale]);

        %labelling the figure
        eps_x=0.16; % offset in x for dimensioning 
        eps_y=0.12; % offset in y for dimensioning

        text(x+a+4*eps_x, y+b/2, 'b','HorizontalAlignment','right'); %labelling b
        text(x+a/2, y-eps_y, 'a','HorizontalAlignment','center'); %labelling a
        text(x+e+d+eps_x+eps_x, y+b+c/2, 'c','HorizontalAlignment','center'); %labelling c
        plot([x+e x+e+d],[y+b+c y+b+c],'k:');%labelling d
        text(x+e+d/2, y+b+c+eps_y+1.5*eps_y, 'd','HorizontalAlignment','center'); %labelling d
        hold off;
        axis off;

        
    case 4  %L shaped
        set(handles.text_input,'Value',4);
        a=5;  %width
        b=2;  %height
        c=4;
        x = 4;
        y = 1;
        base_x = [x x+a  x+a  x+b  x+b   x  x ];
        base_y = [y  y   y+b  y+b  y+c  y+c y ];
        plot(base_x, base_y,'-');
        hold on;
        axis([2 a+6 0 c+3]);

        %labelling the figure
        eps_x=0.16; % offset in x
        eps_y=0.12; % offset in y

        text(x+a+eps_x+eps_x+eps_x, y+b/2, 'b','HorizontalAlignment','right'); %labelling b
        text(x+b/2, y+c+eps_y+eps_y, 'b','HorizontalAlignment','right'); %labelling b

        text(x+a/2, y-eps_y, 'a','HorizontalAlignment','center'); %labelling a
        text(x-eps_x-eps_x, y+c/2, 'c','HorizontalAlignment','center'); %labelling c
        hold off;
        axis off;

        
    case 5 %arbitrary cross section
        set(handles.text_input,'Value',5);
        x1=2; x2=3; x3=3.5; x4=3.3; x5=2.4;
        y1=2; y2=3; y3=4.5; y4=6;   y5=8;
        base_x = [x1 x2 x3 x4 x5];
        base_y = [y1 y2 y3 y4 y5];
        
        plot(base_x, base_y,'-');
        hold on;
        axis([1 4.2 1 11]);

        %labelling the figure
        eps_x=0.16; % offset in x
        eps_y=0.12; % offset in y
        
        t1=text(x1,y1-eps_y-eps_y,'(x1,y1)','HorizontalAlignment','center');%labelling x1,y1
        plot(x1,y1,'ko','MarkerSize',2);
        t2=text(x2+3*eps_x,y2-eps_y-eps_y,'(x2,y2)','HorizontalAlignment','right');%labelling x2,y2
        plot(x2,y2,'ko','MarkerSize',2);
        t3=text(x3+4*eps_x,y3+eps_y,'(x3,y3)','HorizontalAlignment','right');%labelling x3,y3
        plot(x3,y3,'ko','MarkerSize',2);
        t4=text(x4+4*eps_x,y4+eps_y,'(x4,y4)','HorizontalAlignment','right');%labelling x4,y4
        plot(x4,y4,'ko','MarkerSize',2);
        t5=text(x5,y5+3*eps_y,'(x5,y5)','HorizontalAlignment','center');%labelling x5,y5
        plot(x5,y5,'ko','MarkerSize',2);
        hold off;
        axis off;    

end
set(handles.pushbutton_input,'Visible','On');  % enabling the pushbutton 'press to provide inputs'

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function pushbutton_preview_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes_displaycrosssection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_displaycrosssection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%imshow(preview.jpg);
% Hint: place code in OpeningFcn to populate axes_displaycrosssection


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pop_crosssectiontype.
function pop_crosssectiontype_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pop_crosssectiontype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function axes_displaycrosssection_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes_displaycrosssection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text_preview_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_input.
function pushbutton_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%setting callback for button named "press to provide inputs". After
%clicking this button,following function runs setting up(enabling) the panel for receiving user inputs   
val=get(handles.text_input,'Value');
switch val
    case 1 %rectangle
        set(handles.text_I_a,'Enable','on');
        set(handles.text_I_b,'Enable','on');
        set(handles.text_I_c,'Enable','off');
        set(handles.text_I_d,'Enable','off');
        set(handles.edit_I_a,'Enable','on');
        set(handles.edit_I_b,'Enable','on');
        set(handles.edit_I_c,'Enable','off');
        set(handles.edit_I_d,'Enable','off');
        set(handles.pushbutton_I_submit,'Enable','on');
        set(handles.edit_arbit_x,'Enable','off');
        set(handles.edit_arbit_y,'Enable','off');
        set(handles.text_arbit_x,'Enable','off');
        set(handles.text_arbit_y,'Enable','off');
        set(handles.text_arbit_top,'Enable','off');
        set(handles.pushbutton_arbit_submit,'Enable','off');
        set(handles.pushbutton_arbit_next,'Enable','off');
    case 2 %triangle
         set(handles.text_I_a,'Enable','on');
        set(handles.text_I_b,'Enable','on');
        set(handles.text_I_c,'Enable','off');
        set(handles.text_I_d,'Enable','off');
        set(handles.edit_I_a,'Enable','on');
        set(handles.edit_I_b,'Enable','on');
        set(handles.edit_I_c,'Enable','off');
        set(handles.edit_I_d,'Enable','off');
        set(handles.pushbutton_I_submit,'Enable','on');
        set(handles.edit_arbit_x,'Enable','off');
        set(handles.edit_arbit_y,'Enable','off');
        set(handles.text_arbit_x,'Enable','off');
        set(handles.text_arbit_y,'Enable','off');
        set(handles.text_arbit_top,'Enable','off');
        set(handles.pushbutton_arbit_submit,'Enable','off');
        set(handles.pushbutton_arbit_next,'Enable','off');
    case 3 %I shaped
         set(handles.text_I_a,'Enable','on');
        set(handles.text_I_b,'Enable','on');
        set(handles.text_I_c,'Enable','on');
        set(handles.text_I_d,'Enable','on');
        set(handles.edit_I_a,'Enable','on');
        set(handles.edit_I_b,'Enable','on');
        set(handles.edit_I_c,'Enable','on');
        set(handles.edit_I_d,'Enable','on');
        set(handles.pushbutton_I_submit,'Enable','on');
        set(handles.edit_arbit_x,'Enable','off');
        set(handles.edit_arbit_y,'Enable','off');
        set(handles.text_arbit_x,'Enable','off');
        set(handles.text_arbit_y,'Enable','off');
        set(handles.text_arbit_top,'Enable','off');
        set(handles.pushbutton_arbit_submit,'Enable','off');
        set(handles.pushbutton_arbit_next,'Enable','off');
    case 4 %L shaped
        set(handles.text_I_a,'Enable','on');
        set(handles.text_I_b,'Enable','on');
        set(handles.text_I_c,'Enable','on');
        set(handles.text_I_d,'Enable','off');
        set(handles.edit_I_a,'Enable','on');
        set(handles.edit_I_b,'Enable','on');
        set(handles.edit_I_c,'Enable','on');
        set(handles.edit_I_d,'Enable','off');
        set(handles.pushbutton_I_submit,'Enable','on');
        set(handles.edit_arbit_x,'Enable','off');
        set(handles.edit_arbit_y,'Enable','off');
        set(handles.text_arbit_x,'Enable','off');
        set(handles.text_arbit_y,'Enable','off');
        set(handles.text_arbit_top,'Enable','off');
        set(handles.pushbutton_arbit_submit,'Enable','off');
        set(handles.pushbutton_arbit_next,'Enable','off');
    case 5 %arbitrary shaped    
        set(handles.text_I_a,'Enable','off');
        set(handles.text_I_b,'Enable','off');
        set(handles.text_I_c,'Enable','off');
        set(handles.text_I_d,'Enable','off');
        set(handles.edit_I_a,'Enable','off');
        set(handles.edit_I_b,'Enable','off');
        set(handles.edit_I_c,'Enable','off');
        set(handles.edit_I_d,'Enable','off');
        set(handles.pushbutton_I_submit,'Enable','off');
        set(handles.edit_arbit_x,'Enable','on');
        set(handles.edit_arbit_y,'Enable','on');
        set(handles.text_arbit_x,'Enable','on');
        set(handles.text_arbit_y,'Enable','on');
        set(handles.text_arbit_top,'Enable','on');
        set(handles.pushbutton_arbit_submit,'Enable','off');
        set(handles.pushbutton_arbit_next,'Enable','on');
    otherwise
end





function edit_I_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_I_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I_a as text
%        str2double(get(hObject,'String')) returns contents of edit_I_a as a double


% --- Executes during object creation, after setting all properties.
function edit_I_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_I_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_I_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_I_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I_b as text
%        str2double(get(hObject,'String')) returns contents of edit_I_b as a double


% --- Executes during object creation, after setting all properties.
function edit_I_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_I_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_I_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_I_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I_c as text
%        str2double(get(hObject,'String')) returns contents of edit_I_c as a double


% --- Executes during object creation, after setting all properties.
function edit_I_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_I_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_I_d_Callback(hObject, eventdata, handles)
% hObject    handle to edit_I_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I_d as text
%        str2double(get(hObject,'String')) returns contents of edit_I_d as a double


% --- Executes during object creation, after setting all properties.
function edit_I_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_I_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_arbit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arbit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arbit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_arbit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_arbit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arbit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_arbit_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arbit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arbit_y as text
%        str2double(get(hObject,'String')) returns contents of edit_arbit_y as a double


% --- Executes during object creation, after setting all properties.
function edit_arbit_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arbit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in pushbutton_arbit_next.
function pushbutton_arbit_next_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arbit_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the 'next coordinate' button provided within the panel taking
%inputs for arbitrary cross-sections. Clicking the button runs following
%set of codes. It accepts user input for x and y coordinates (for arbitrary cross sections) and enables
%the submit button upon entry of 3 coordinate sets 
x=str2num(get(handles.edit_arbit_x,'String'));
y=str2num(get(handles.edit_arbit_y,'String')); 
set(handles.edit_arbit_x,'String','');
set(handles.edit_arbit_y,'String','');
if ~isempty(x)&&~isempty(y)
    a=get(handles.text_x_array,'Value');
    b=get(handles.text_y_array,'Value');
    set(handles.text_x_array,'Value',[a x]);
    set(handles.text_y_array,'Value',[b y]);
    a=get(handles.text_x_array,'Value');
    b=get(handles.text_y_array,'Value');
    if size(a,2)==3&&size(b,2)==3
        set(handles.pushbutton_arbit_submit,'Enable','On');
    end
    
end
    
    

% --- Executes on button press in pushbutton_nextpage.
function pushbutton_nextpage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nextpage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'confirm and go to next page'.following
%function executes after pressing above button.Stores the value of key
%parameters such as a,b,c,d,x_array,y_array in the root directory to be
%used in 2nd page
%It also closes the current page and opens up  page 2
x1=get(handles.text_x_array,'Value');
y1=get(handles.text_y_array,'Value');
set(handles.text_x_array,'Value',x1);
set(handles.text_y_array,'Value',y1);
x=get(handles.text_x_array,'Value');
y=get(handles.text_y_array,'Value');
a=get(handles.text_a,'Value');
b=get(handles.text_b,'Value');
c=get(handles.text_c,'Value');
d=get(handles.text_d,'Value');
crosssection=get(handles.text_input,'Value');
setappdata(0,'a',a); setappdata(0,'b',b); setappdata(0,'c',c);
setappdata(0,'d',d); setappdata(0,'x',x); setappdata(0,'y',y);
setappdata(0,'crosssection',crosssection);
close(input_gui);
page_2_gui;




% --- Executes on button press in pushbutton_I_submit.
function pushbutton_I_submit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_I_submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'submit' in the panel accepting values for a,b,c,d.following
%function executes after pressing above button. Accepts user input in form
%of a,b,c,d. It disable various edit, text fields and submit buttons and
%enables Reset and nextpage buttons
 a=str2num(get(handles.edit_I_a,'String'));
 b=str2num(get(handles.edit_I_b,'String'));
 c=str2num(get(handles.edit_I_c,'String'));
 d=str2num(get(handles.edit_I_d,'String'));
 set(handles.text_a,'Value',a);
 set(handles.text_b,'Value',b);
 set(handles.text_c,'Value',c);
 set(handles.text_d,'Value',d);
 
 handle_array = [handles.pop_crosssectiontype, handles.pushbutton_preview, handles.pushbutton_input, ...
     handles.text_I_a, handles.text_I_b, handles.text_I_c, handles.text_I_d, handles.text_arbit_x...
    ,handles.text_arbit_y, handles.text_arbit_top, handles.edit_I_a, handles.edit_I_b, handles.edit_I_c, handles.edit_I_d...
    ,handles.edit_arbit_x, handles.edit_arbit_y, handles.pushbutton_I_submit, handles.pushbutton_arbit_next, handles.pushbutton_arbit_submit];
 set(handle_array,'Enable','Off');   %disabling text fields
 enable_array = [handles.pushbutton_reset,handles.pushbutton_nextpage];
 set(enable_array,'Enable','on');    %enabling reset and next page buttons

% --- Executes on button press in pushbutton_arbit_submit.
function pushbutton_arbit_submit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arbit_submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%callback function for the button 'submit' in the panel accepting values for arbitrary cross-section .following
%function executes after pressing above button. disables all text,edit
%fields and enables  reset and next page buttons
x=str2num(get(handles.edit_arbit_x,'String'));
y=str2num(get(handles.edit_arbit_y,'String'));
if ~isempty(x)&&~isempty(y)
    a=get(handles.text_x_array,'Value');
    b=get(handles.text_y_array,'Value');
    set(handles.text_x_array,'Value',[a x]);
    set(handles.text_y_array,'Value',[b y]);
end
    
handle_array = [handles.pop_crosssectiontype, handles.pushbutton_preview, handles.pushbutton_input, ...
     handles.text_I_a, handles.text_I_b, handles.text_I_c, handles.text_I_d, handles.text_arbit_x...
    ,handles.text_arbit_y, handles.text_arbit_top, handles.edit_I_a, handles.edit_I_b, handles.edit_I_c, handles.edit_I_d...
    ,handles.edit_arbit_x, handles.edit_arbit_y, handles.pushbutton_I_submit, handles.pushbutton_arbit_next, handles.pushbutton_arbit_submit];
 set(handle_array,'Enable','Off');    %disabling text fields
 enable_array = [handles.pushbutton_reset,handles.pushbutton_nextpage];
 set(enable_array,'Enable','on');     %enabling reset and next page buttons


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%callback function for the button 'Reset'.following
%function executes after pressing above button. Reinitializes the first
%page
 enable_array = [handles.pop_crosssectiontype, handles.pushbutton_preview, handles.pushbutton_input];
clear_edit_array = [handles.edit_I_a, handles.edit_I_b, handles.edit_I_c, handles.edit_I_d, handles.edit_arbit_x, handles.edit_arbit_y];
clear_text_array = [handles.text_x_array, handles.text_y_array, handles.text_a,handles.text_b,handles.text_c,handles.text_d];
 set(enable_array,'Enable','On');
 set(clear_edit_array,'String','');
 set(clear_text_array,'Value',[]);
 set(handles.pushbutton_nextpage,'Enable','off');   %disabling text fields and pushbuttons to reinitialize input page
 set(handles.pushbutton_reset,'Enable','off');


% --- Executes during object creation, after setting all properties.
function pushbutton_nextpage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_nextpage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
