project('getxkblayout', 'c')

x11_dep = dependency('X11')
xkbfile_dep = dependency('xkbfile')

executable('getxkblayout', 'src/getxkblayout.c', dependencies: [x11_dep, xkbfile_dep], install: true)
