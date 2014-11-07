######################################################################
# Automatically generated by qmake (2.01a) Thu Dec 13 13:25:01 2007
######################################################################


include(../../_Builds/eidcommon.mak)

TEMPLATE = lib
TARGET = $${CARDPLUGIN}
VERSION = $${CARDPLUGIN_MAJ}.$${CARDPLUGIN_MIN}.$${CARDPLUGIN_REV}

message("Compile $$TARGET")

###
### Installation setup
###
target.path = $${INSTALL_DIR_LIB}
INSTALLS += target

CONFIG -= warn_on qt

## destination directory
DESTDIR = ../../lib
DEPENDPATH += . 
macx: LIBS += -L../../lib -l$${COMMONLIB}
macx: LIBS += -l$${DLGLIB} \
              -l$${CARDLAYERLIB}  \
              -Wl,-framework -Wl,PCSC 	

INCLUDEPATH += . .. ../../common
INCLUDEPATH += $${PCSC_INCLUDE_DIR}

QMAKE_CXXFLAGS += -O2
unix:!macx: QMAKE_CXXFLAGS += -fPIC

DEFINES += EIDMW_CAL_EXPORT
unix:!macx:  DEFINES += __UNIX__
#Support Fat binaries on Mac with both x86 and x86_64 architectures
macx: CONFIG += x86

# Input
HEADERS += PteidCard.h \
           PteidP15Correction.h \
           ../Cache.h \
           ../Card.h \
           ../CardLayerConst.h \
           ../Context.h \
           ../InternalConst.h \
           ../P15Correction.h \
           ../P15Objects.h \
           ../PCSC.h \
           ../Pinpad.h \
           ../PinpadLib.h \
           ../PKCS15.h \
           ../PKCS15Parser.h \
           ../PkiCard.h \
           ../../common/ByteArray.h

SOURCES += PteidCard.cpp \
           PteidP15Correction.cpp \
           ../Cache.cpp \
           ../Card.cpp \
           ../PkiCard.cpp

isEmpty(RELEASE_BUILD){
  macx:{
    ##
    ## Build the emulation as well
    ## This is needed only on mac because on linux it is sufficient to
    ## link the executables against the cardlayer emulation lib and
    ## emulation plugins are not necessary.
    ##
    emulation.depends = $(SOURCES) cardpluginPteidEmulation.pro
    unix:!macx: emulation.target = $${DESTDIR}/lib$${CARDPLUGINEMU}.so
    macx: emulation.target = $${DESTDIR}/lib$${CARDPLUGINEMU}.dylib
    
#    emulation.commands = rm -rf tmp; mkdir tmp; cd tmp; \
    emulation.commands = mkdir -p tmp; cd tmp; \
                       qmake PKG_NAME=$${PKG_NAME} ../cardpluginPteidEmulation.pro -o Makefile.emu; make -f Makefile.emu; \
                       make -f Makefile.emu ; \
#                       cd ../ ; rm -rf tmp
                       cd ../

    
    QMAKE_EXTRA_TARGETS += emulation
    PRE_TARGETDEPS += $${emulation.target}
  }
}
