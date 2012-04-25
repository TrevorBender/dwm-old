void
focusroot(const Arg * arg) {
    Client * c = NULL;
    if (!selmon->sel)
        return;
    c = selmon->clients;
    if (c)
        focus (c);
}
