#include <stdio.h>
#include <stdlib.h>

#include <errno.h>
#include <error.h>
#include <string.h>

#include <X11/Xlib.h>
#include <X11/XKBlib.h>
#include <X11/extensions/XKBrules.h>

void fail(int errnum, const char *errmsg) {
  error(0, errnum, "%s", errmsg);
  exit(EXIT_FAILURE);
}

int main(int argc, char **argv) {

  Display *dpy = XOpenDisplay(NULL);
  if (dpy == NULL) {
    fail(ENXIO, "Cannot open display");
  }

  XkbStateRec state;
  XkbGetState(dpy, XkbUseCoreKbd, &state);

  XkbRF_VarDefsRec vd;
  XkbRF_GetNamesProp(dpy, NULL, &vd);
  XCloseDisplay(dpy);

  char *tok = strtok(vd.layout, ",");

  for (int i = 0; i < state.group; i++) {
    tok = strtok(NULL, ",");
    if (tok == NULL) {
      fail(ENXIO, "Failed to get keyboard group");
    }
  }

  printf("%s\n", tok);

  return EXIT_SUCCESS;
}
