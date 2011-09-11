void
warpmouse(const Arg *arg)
{
    if (!arg) return;
    if (!arg->v) return;
    const int* mouse_coords = (int*)arg->v;
    if (LENGTH (mouse_coords) != 2) return;

    int x = mouse_coords[0], y = mouse_coords[1];

    XWarpPointer(dpy, None, root, 0, 0, 0, 0, x, y);
}
