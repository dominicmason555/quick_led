from cx_Freeze import setup, Executable
import sys


# dependencies
build_exe_options = {
    "packages": ["PySide2", "sys", "os", "requests", "logging", "urllib3"],
    "excludes": ["tkinter", "tkconstants", "tcl", "tk"],
    "include_files": "view.qml",
    "build_exe": "build",
    "optimize": 2
}

executable = [
    Executable("main.py",
               base = ("Win32GUI" if sys.platform == "win32" else None),
               targetName = "led_controller.exe"
               )
    ]



setup(name = "Main",
      version = "0.2",
      description = "test",
      options = {"build_exe": build_exe_options},
      executables = executable
      )
