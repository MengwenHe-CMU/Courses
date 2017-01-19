#-------------------------------------------------
#
# Project created by QtCreator 2016-11-28T14:27:52
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = hackathon
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    qmatlabinterface.cpp

HEADERS  += mainwindow.h \
    qmatlabinterface.h

FORMS    += mainwindow.ui

win32:INCLUDEPATH += "C:/Program Files/MATLAB/R2016a/extern/include"
win32:LIBS += \
    "C:/Program Files/MATLAB/R2016a/extern/lib/win64/microsoft/libmx.lib" \
    "C:/Program Files/MATLAB/R2016a/extern/lib/win64/microsoft/libmex.lib" \
    "C:/Program Files/MATLAB/R2016a/extern/lib/win64/microsoft/libmat.lib" \
    "C:/Program Files/MATLAB/R2016a/extern/lib/win64/microsoft/libeng.lib"
