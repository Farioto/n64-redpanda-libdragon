#include <libdragon.h>

static sprite_t *panda_sprite;
static rspq_block_t *panda_block;

void update(int ovfl)
{
    (void)ovfl;
}

void render(int cur_frame)
{
    (void)cur_frame;

    surface_t *disp = display_get();
    rdpq_attach_clear(disp, NULL);

    if (!panda_block) {
        rspq_block_begin();

            rdpq_set_mode_copy(false);

            int dw = display_get_width();
            int dh = display_get_height();
            int sw = panda_sprite->width;
            int sh = panda_sprite->height;

            rdpq_sprite_blit(
                panda_sprite,
                0, 0,
                &(rdpq_blitparms_t){
                    .scale_x = (float)dw / (float)sw,
                    .scale_y = (float)dh / (float)sh,
                }
            );

            rdpq_set_mode_standard();
            rdpq_mode_filter(FILTER_BILINEAR);
            rdpq_mode_alphacompare(1);
            rdpq_mode_antialias(false);
            rdpq_mode_blender(RDPQ_BLENDER_MULTIPLY);

        panda_block = rspq_block_end();
    }

    rspq_block_run(panda_block);
    rdpq_detach_show();
}

int main(void)
{
    debug_init_isviewer();
    debug_init_usblog();

    display_init(RESOLUTION_640x480, DEPTH_16_BPP, 3,
                 GAMMA_NONE, FILTERS_DISABLED);

    dfs_init(DFS_DEFAULT_LOCATION);
    rdpq_init();

    panda_sprite = sprite_load("rom:/panda.sprite");
    if (!panda_sprite) {
        debugf("FAILED TO LOAD panda.sprite\n");
        while (1);
    }

    debugf("panda loaded: %dx%d fmt=%d\n",
           panda_sprite->width,
           panda_sprite->height,
           sprite_get_format(panda_sprite));

    int cur_frame = 0;
    while (1) {
        update(0);
        render(cur_frame++);
    }
}
