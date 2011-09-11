
static unsigned int persistent_tags[LENGTH(tags)];

static unsigned int cur_tag = 0;
static unsigned int cur_idx = 0;

void view_persistent_tags (Monitor *sel_mon)
{
    unsigned int per_sel = persistent_tags[cur_idx];
    unsigned int new_tags_set = selmon->tagset[selmon->seltags] ^ (per_sel & TAGMASK);
    new_tags_set |= cur_tag;

    if (new_tags_set) {
		selmon->tagset[selmon->seltags] = new_tags_set;
    }
}

void current_tag (unsigned int tag)
{
    unsigned int mask = tag;
    cur_tag = tag;
    cur_idx = 0;
    if (tag == 0) return;

    while (mask > 1) {
        mask = mask >> 1;
        cur_idx++;
    }
}

void toggle_tag (unsigned int tag) 
{
    persistent_tags[cur_idx] = tag;
}
