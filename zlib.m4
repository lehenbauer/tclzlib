AC_DEFUN([LIB_ZLIB],
[ZLIB_CPPFLAGS=
ZLIB_LDFLAGS=
ZLIB_LIBS=
AC_ARG_WITH([zlib],
    [AC_HELP_STRING([--with-zlib@<:@=PATH@:>@],
        [Set the path of zlib])],
    ZLIB_DIR=$with_zlib,ZLIB_DIR=yes

    AC_MSG_CHECKING([for zlib location])
    if test x"$ZLIB_DIR" = xyes ; then
        for dir in $prefix /usr/local /usr ; do
            if test -f "$dir/include/zlib.h" ; then
                ZLIB_DIR=$dir
                break
            fi
        done
    fi
    if test x"$ZLIB_DIR" = xyes ; then
	AC_MSG_RESULT([no])
    else
        AC_MSG_RESULT([$ZLIB_DIR])
        if test x"$ZLIB_DIR" != x/usr ; then
            ZLIB_CPPFLAGS="-I$ZLIB_DIR/include"
            ZLIB_LDFLAGS="-L$ZLIB_DIR/lib"
        fi
        zlib_save_LDFLAGS=$LDFLAGS
        LDFLAGS="$ZLIB_LDFLAGS $LDFLAGS"
        AC_CHECK_LIB([z], [compress], [ZLIB_LIBS=-lz],
            [AC_MSG_ERROR([cannot find libz])])
        LDFLAGS=$zlib_save_LDFLAGS
        AC_DEFINE([HAVE_ZLIB], 1, [Define if zlib is available.])
    fi

AC_SUBST([ZLIB_CPPFLAGS])
AC_SUBST([ZLIB_LDFLAGS])
AC_SUBST([ZLIB_LIBS])]