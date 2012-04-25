
void
book(Monitor *m) {
    int x, y, h, w, mw;
    unsigned int n, i;
    Client *c;
    for(n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++);
    if(n == 0)
        return;
    /* master */
    c = nexttiled(m->clients);
    mw = m->mfact * m->ww;
    resize(c, m->wx, m->wy, (n == 1 ? m->ww : mw) - 2 * c->bw, m->wh - 2 * c->bw, False);
    if(--n == 0)
        return;
    /* stack */
    x = (m->wx > c->x) ? c->x + mw + 2 * c->bw : m->wx + mw;
    y = m->wy;
    w = (m->wx > c->x) ? m->wx + m->ww - x : m->ww - mw;
    h = m->wh;
    if(h < bh)
        h = m->wh;
    for(i = 0, c = nexttiled(c->next); c; c = nexttiled(c->next), i++) {
        resize(c, x, y, w - 2 * c->bw, /* remainder */ ((i + 1 == n)
                    ? m->wy + m->wh - y - 2 * c->bw : h - 2 * c->bw), False);
    }
}
