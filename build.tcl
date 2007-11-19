# Call this script with the tclsh you'd like to build the extension against
# Optional argument is the location of tclConfig.sh

if { [llength $argv] == 0 } {
    set tclconfig [file dirname [info library]]
} else {
    set tclconfig [lindex $argv 0]
}

# Optional build of bundled zlib
if { [file exists zlib] } {
    cd zlib
    puts "**** Configure zlib ****"
    exec sh configure >@ stdout 2>@ stderr
    puts "**** Build zlib ****"
    exec make >@ stdout 2>@ stderr
    cd ..
}

puts "**** Configure zlib extension ****"
exec sh configure --with-tcl=$tclconfig --with-zlib=./zlib >@ stdout 2>@ stderr
puts "**** Build tcl extension ****"
exec make >@ stdout 2>@ stderr

puts "**** Done. You may want to run 'make install' ****"



