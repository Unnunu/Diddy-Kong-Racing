#include "borders.h"

#include "camera.h"
#include "f3ddkr.h"
#include "game.h"
#include "game_ui.h"
#include "macros.h"
#include "structs.h"
#include "types.h"
#include "video.h"

/**
 * Renders the black borders that separate each viewport during multiplayer.
 * 2 player has a single horizontal line, while 3 and 4 player splits the screen into quadrants.
 * 3 player will completely fill in where player 4 would normally be.
 */
void divider_draw(Gfx **dList) {
    u32 widthAndHeight, width, height;
    u32 y, x, xOffset, yOffset;
    LevelHeader *levelHeader;

    widthAndHeight = fb_size();
    width = GET_VIDEO_WIDTH(widthAndHeight);
    height = GET_VIDEO_HEIGHT(widthAndHeight);
    xOffset = width / 256;
    width += 0; // Fake match?
    yOffset = height / 128;
    gDPSetCycleType((*dList)++, G_CYC_FILL);
    gDPSetFillColor((*dList)++, GPACK_RGBA5551(0, 0, 0, 1) << 16 | GPACK_RGBA5551(0, 0, 0, 1)); // Black fill color
    switch (cam_get_viewport_layout()) {
        case VIEWPORT_LAYOUT_2_PLAYERS:
            // Draws a solid horizontal black line in the middle of the screen.
            y = (height >> 1) - yOffset;
            gDPFillRectangle((*dList)++, height * 0, y, width, y + yOffset);
            break;
        case VIEWPORT_LAYOUT_3_PLAYERS:
            levelHeader = level_header();
            // Draw black square in the bottom-right corner.
            if (hud_setting() || (levelHeader->race_type & RACETYPE_CHALLENGE)) {
                gDPFillRectangle((*dList)++, width >> 1, height >> 1, width, height);
            }
            // There is no break statement here. This is intentional.
        case VIEWPORT_LAYOUT_4_PLAYERS:
            x = (width >> 1) - xOffset;
            // Draws 2 black lines in the middle of the screen. One vertical, another horizontal.
            gDPFillRectangle((*dList)++, height * 0, (height >> 1) - yOffset, width,
                             ((height >> 1) - yOffset) + yOffset);
            gDPFillRectangle((*dList)++, x, 0, x + xOffset, height);
            break;
    }
}

/**
 * Draws the multiplayer borders again, but fully invisible using the XLU render mode.
 * The effect here is that it will strip coverage for anything beneath, eliminating pixel bleed.
 */
void divider_clear_coverage(Gfx **dList) {
    u32 screenSize;
    u32 screenWidth;
    u32 screenHeight;
    u32 height;
    u32 width;
    u32 tempX;
    u32 tempY;

    screenSize = fb_size();
    screenHeight = GET_VIDEO_HEIGHT(screenSize);
    screenWidth = GET_VIDEO_WIDTH(screenSize);
    height = (screenHeight / 128) << 1 << 1;
    width = (screenWidth / 256) << 1 << 1;
    gDPSetCycleType((*dList)++, G_CYC_1CYCLE);
    gDPSetCombineMode((*dList)++, G_CC_PRIMITIVE, G_CC_PRIMITIVE);
    gDPSetRenderMode((*dList)++, G_RM_XLU_SURF, G_RM_XLU_SURF2);
    gDPSetPrimColor((*dList)++, 0, 0, 0, 0, 0, 0);
    switch (cam_get_viewport_layout()) {
        case VIEWPORT_LAYOUT_2_PLAYERS:
            tempY = (screenHeight / 2) - (height / 2);
            gDPFillRectangle((*dList)++, 0, tempY, screenWidth, tempY + height);
            break;
        case VIEWPORT_LAYOUT_3_PLAYERS:
        case VIEWPORT_LAYOUT_4_PLAYERS:
            tempY = (screenHeight / 2) - (height / 2);
            tempX = (screenWidth / 2) - (width / 2);
            gDPFillRectangle((*dList)++, 0, tempY, screenWidth, tempY + height);
            tempX += 0; // Fakematch
            gDPFillRectangle((*dList)++, tempX, 0, tempX + width, screenHeight);
            break;
    }
}
