#!/usr/bin/bash

function set_java_home(){
	file=$1
	jdk_path=$2
	echo "Set JAVA_HOME: $jdk_path in $file"

	sed -i "s/export JAVA_HOME=\".*\"/export JAVA_HOME=\"\/usr\/lib\/jvm\/${jdk_path}\"/g" "$file"
	cat $file | grep "JAVA_HOME"

	export JAVA_HOME="/usr/lib/jvm/${jdk_path}"
}

function update_alternatives_install_java(){
	jdk_path=$1
	echo "update-alternatives java with $jdk_path"
	sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/${jdk_path}/bin/java 1411
}

function update_alternatives_install_javac(){
	jdk_path=$1
	echo "update-alternatives javac with $jdk_path"
	sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/${jdk_path}/bin/javac 1411
}

function update_alternatives_config_java(){
	echo "update-alternatives config java"
	sudo update-alternatives --config java
}

function update_alternatives_config_javac(){
	echo "update-alternatives config javac"
	sudo update-alternatives --config javac
}

function main(){
	jdk_path=$1
	set_java_home ~/.zshrc $jdk_path
	set_java_home ~/.bashrc $jdk_path

	update_alternatives_install_java $jdk_path
	update_alternatives_install_javac $jdk_path

	update_alternatives_config_java
	update_alternatives_config_javac

	echo "--------------JAVA  VERSION--------------"
	java --version
	echo "--------------JAVAC VERSION--------------"
	javac --version
	echo "--------------MVN   VERSION--------------"
	mvn --version
}

jdk_path=$1


main $jdk_path
