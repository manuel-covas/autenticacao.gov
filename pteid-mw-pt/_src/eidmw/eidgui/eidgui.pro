######################################################################
# Automatically generated by qmake (2.01a) Thu Jan 10 18:23:36 2008
######################################################################


include(../_Builds/eidcommon.mak)

TEMPLATE = app
TARGET = $${EIDGUI} 
VERSION = $${EIDGUI_MAJ}.$${EIDGUI_MIN}.$${EIDGUI_REV}

QT += network

message("Compile $$TARGET")

###
### Installation setup
###
target.path = $${INSTALL_DIR_BIN}

## the following lines are needed in order to have
## the translation files included in the set
## of files to install
translations.path = $${INSTALL_DIR_BIN}
translations.files += eidmw_en.qm \
	        eidmw_nl.qm 

INSTALLS += target translations

###
### Compiler setup
###

CONFIG -= warn_on
CONFIG += config qt thread create_prl link_prl console

##LIBS += -L$$[QT_INSTALL_PLUGINS]/imageformats -ljasper

###
### Accept cp1252 encoded source files
### 
###
#QMAKE_CXXFLAGS+=-finput-charset=cp1252

###
### make sure the RPATH is set to where the Qt libs will be installed
###
##QMAKE_RPATH=-Wl,-rpath,../lib/pteidqt
##QMAKE_RPATH=-Wl,-rpath,/usr/local/lib/pteidqt/
QMAKE_RPATH=

QTPLUGIN += 

## destination directory for the compiler
DESTDIR = ../bin


## --------------------------------------------------------------------------------------------------------
## Take care of copying the translation files to the 
## destination directory
## --------------------------------------------------------------------------------------------------------
FINALDIR=$${DESTDIR}
macx: FINALDIR=$${DESTDIR}/$${EIDGUI}.app/Contents/MacOS/


translation_en.depends = eidmw_en.qm
translation_en.target = $${FINALDIR}/eidmw_en.qm
translation_en.commands = ! [ -d $${FINALDIR} ] && mkdir -p $${FINALDIR}; \
                          cp $$translation_en.depends $$translation_en.target
QMAKE_EXTRA_TARGETS += translation_en


translation_nl.depends = eidmw_nl.qm
translation_nl.target = $${FINALDIR}/eidmw_nl.qm
translation_nl.commands = ! [ -d $${FINALDIR} ] && mkdir -p $${FINALDIR}; \
                          cp $$translation_nl.depends $$translation_nl.target
QMAKE_EXTRA_TARGETS += translation_nl


PRE_TARGETDEPS += $${translation_en.target} \
		$${translation_nl.target} 

## --------------------------------------------------------------------------------------------------------

DEPENDPATH += . ../dialogs 
INCLUDEPATH += . ../dialogs ../eidlib ../_Builds ../common
INCLUDEPATH += /usr/include/cairo

LIBS += -L../lib  \
    -l$${EIDLIB} \
	-l$${COMMONLIB}

unix:!macx: LIBS += -Wl,-rpath-link,../lib

LIBS += -lcairo

macx: LIBS += -framework Foundation

isEmpty(EMULATE_CARDLAYER) {
  LIBS +=	-l$${CARDLAYERLIB} 
  macx: LIBS += -Wl,-framework -Wl,PCSC 	
} else {
  LIBS += -l$${CARDLAYEREMULIB} 
}

unix:!macx:LIBS += -lX11 -Wl,-R,"'\$\$ORIGIN/$${LINK_RELATIVE_PATH}'"
LIBS +=	-l$${DLGLIB}

# Input
HEADERS += CardInformation.h \
           dlgAbout.h \
           dlgOptions.h \
           httpwindow.h \
					 AutoUpdates.h \
					 mainwnd.h \
					 Settings.h \
					 genpur.h \
					 picturepopup.h \
					 qtsingleapplication.h \
					 dlgprint.h \
					 dlgverifysignature.h \
					 mylistview.h \
					 dlgsignature.h \
					 PDFSignWindow.h \
					 ChangeAddressDialog.h \
					 ../_Builds/pteidversions.h \
					 ../dialogs/dialogs.h
           
FORMS += dlgAbout.ui dlgOptions.ui mainwnd.ui picturepopup.ui dlgPrint.ui dlgSignature.ui dlgVerifySignature.ui PDFSignWindow.ui ChangeAddressDialog.ui

RESOURCES = eidgui.qrc 

SOURCES += CardInformation.cpp \
           dlgAbout.cpp \
           dlgOptions.cpp \
           httpwindow.cpp \
           AutoUpdates.cpp \
           ChangeAddressDialog.cpp \
           main.cpp \
           mainwnd.cpp \
		   dlgprint.cpp \
		   dlgverifysignature.cpp \
		   dlgsignature.cpp \
			picturepopup.cpp \
			qtsingleapplication.cpp \
					 PDFSignWindow.cpp \
					 mylistview.cpp \
					 genpur.cpp
unix:!macx: SOURCES += qtsingleapplication_x11.cpp
macx: SOURCES += qtsingleapplication_mac.cpp	



