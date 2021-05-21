function varargout = DemoFigure(varargin)
% DEMOFIGURE MATLAB code for DemoFigure.fig
%      DEMOFIGURE, by itself, creates a new DEMOFIGURE or raises the existing
%      singleton*.
%
%      H = DEMOFIGURE returns the handle to a new DEMOFIGURE or the handle to
%      the existing singleton*.
%
%      DEMOFIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMOFIGURE.M with the given input arguments.
%
%      DEMOFIGURE('Property','Value',...) creates a new DEMOFIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DemoFigure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DemoFigure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DemoFigure

% Last Modified by GUIDE v2.5 26-Nov-2017 15:45:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DemoFigure_OpeningFcn, ...
                   'gui_OutputFcn',  @DemoFigure_OutputFcn, ...
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



% --- Executes just before DemoFigure is made visible.
function DemoFigure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DemoFigure (see VARARGIN)

hObject.Units = 'normalized';
handles.figure1.Units = 'normalized';
% The Code That Makes Everything Work
% *************************************************************************
% *************************************************************************
Example_Program % <----------*********************************************
% *************************************************************************
% *************************************************************************
% open('Example_Program.m')






% UIWAIT makes DemoFigure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DemoFigure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
