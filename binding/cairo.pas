//
// cairo.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(* cairo - a vector graphics library with display and print output
 *
 * Copyright © 2002 University of Southern California
 * Copyright © 2005 Red Hat, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it either under the terms of the GNU Lesser General Public
 * License version 2.1 as published by the Free Software Foundation
 * (the "LGPL") or, at your option, under the terms of the Mozilla
 * Public License Version 1.1 (the "MPL"). If you do not alter this
 * notice, a recipient may use your version of this file under either
 * the MPL or the LGPL.
 *
 * You should have received a copy of the LGPL along with this library
 * in the file COPYING-LGPL-2.1; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1335, USA
 * You should have received a copy of the MPL along with this library
 * in the file COPYING-MPL-1.1
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY
 * OF ANY KIND, either express or implied. See the LGPL or the MPL for
 * the specific language governing rights and limitations.
 *
 * The Original Code is the cairo graphics library.
 *
 * The Initial Developer of the Original Code is University of Southern
 * California.
 *
 * Contributor(s):
 *  Carl D. Worth <cworth@cworth.org>
 *)

unit cairo;

{$mode objfpc}{$H+}

interface

{$include cairo_features.inc}

uses
  ctypes;

{$include cairo_version.inc}

const
  LIB_CAIRO = 'libcairo-2.dll';

//TODO #define CAIRO_VERSION_ENCODE(major, minor, micro) (  \
//TODO     ((major) * 10000)        \
//TODO   + ((minor) *   100)        \
//TODO   + ((micro) *     1))
//TODO 
//TODO #define CAIRO_VERSION CAIRO_VERSION_ENCODE(  \
//TODO   CAIRO_VERSION_MAJOR,      \
//TODO   CAIRO_VERSION_MINOR,      \
//TODO   CAIRO_VERSION_MICRO)
//TODO 
//TODO 
//TODO #define CAIRO_VERSION_STRINGIZE_(major, minor, micro)  \
//TODO   #major"."#minor"."#micro
//TODO #define CAIRO_VERSION_STRINGIZE(major, minor, micro)  \
//TODO   CAIRO_VERSION_STRINGIZE_(major, minor, micro)
//TODO 
//TODO #define CAIRO_VERSION_STRING CAIRO_VERSION_STRINGIZE(  \
//TODO   CAIRO_VERSION_MAJOR,        \
//TODO   CAIRO_VERSION_MINOR,        \
//TODO   CAIRO_VERSION_MICRO)

function cairo_version(): cint; cdecl; external LIB_CAIRO;

function cairo_version_string(): pchar; cdecl; external LIB_CAIRO;

type
(**
 * cairo_bool_t:
 *
 * #cairo_bool_t is used for boolean values. Returns of type
 * #cairo_bool_t will always be either 0 or 1, but testing against
 * these values explicitly is not encouraged; just use the
 * value as a boolean condition.
 *
 * <informalexample><programlisting>
 *  if (cairo_in_stroke (cr, x, y)) {
 *      /<!-- -->* do something *<!-- -->/
 *  }
 * </programlisting></informalexample>
 *
 * Since: 1.0
 **)
  cairo_bool_t = cint;

(**
 * cairo_t:
 *
 * A #cairo_t contains the current state of the rendering device,
 * including coordinates of yet to be drawn shapes.
 *
 * Cairo contexts, as #cairo_t objects are named, are central to
 * cairo and all drawing with cairo is always done to a #cairo_t
 * object.
 *
 * Memory management of #cairo_t is done with
 * cairo_reference() and cairo_destroy().
 *
 * Since: 1.0
 **)
  Pcairo_t = ^cairo_t;
  cairo_t = record
  end;

(**
 * cairo_surface_t:
 *
 * A #cairo_surface_t represents an image, either as the destination
 * of a drawing operation or as source when drawing onto another
 * surface.  To draw to a #cairo_surface_t, create a cairo context
 * with the surface as the target, using cairo_create().
 *
 * There are different subtypes of #cairo_surface_t for
 * different drawing backends; for example, cairo_image_surface_create()
 * creates a bitmap image in memory.
 * The type of a surface can be queried with cairo_surface_get_type().
 *
 * The initial contents of a surface after creation depend upon the manner
 * of its creation. If cairo creates the surface and backing storage for
 * the user, it will be initially cleared; for example,
 * cairo_image_surface_create() and cairo_surface_create_similar().
 * Alternatively, if the user passes in a reference to some backing storage
 * and asks cairo to wrap that in a #cairo_surface_t, then the contents are
 * not modified; for example, cairo_image_surface_create_for_data() and
 * cairo_xlib_surface_create().
 *
 * Memory management of #cairo_surface_t is done with
 * cairo_surface_reference() and cairo_surface_destroy().
 *
 * Since: 1.0
 **)
  Pcairo_surface_t = ^cairo_surface_t;
  cairo_surface_t = record
  end;

(**
 * cairo_device_t:
 *
 * A #cairo_device_t represents the driver interface for drawing
 * operations to a #cairo_surface_t.  There are different subtypes of
 * #cairo_device_t for different drawing backends; for example,
 * cairo_egl_device_create() creates a device that wraps an EGL display and
 * context.
 *
 * The type of a device can be queried with cairo_device_get_type().
 *
 * Memory management of #cairo_device_t is done with
 * cairo_device_reference() and cairo_device_destroy().
 *
 * Since: 1.10
 **)
  Pcairo_device_t = ^cairo_device_t;
  cairo_device_t = record
  end;

(**
 * cairo_matrix_t:
 * @xx: xx component of the affine transformation
 * @yx: yx component of the affine transformation
 * @xy: xy component of the affine transformation
 * @yy: yy component of the affine transformation
 * @x0: X translation component of the affine transformation
 * @y0: Y translation component of the affine transformation
 *
 * A #cairo_matrix_t holds an affine transformation, such as a scale,
 * rotation, shear, or a combination of those. The transformation of
 * a point (x, y) is given by:
 * <programlisting>
 *     x_new = xx * x + xy * y + x0;
 *     y_new = yx * x + yy * y + y0;
 * </programlisting>
 *
 * Since: 1.0
 **)
  Pcairo_matrix_t = ^cairo_matrix_t;
  cairo_matrix_t = record
    xx: cdouble; yx: cdouble;
    xy: cdouble; yy: cdouble;
    x0: cdouble; y0: cdouble;
  end;

(**
 * cairo_pattern_t:
 *
 * A #cairo_pattern_t represents a source when drawing onto a
 * surface. There are different subtypes of #cairo_pattern_t,
 * for different types of sources; for example,
 * cairo_pattern_create_rgb() creates a pattern for a solid
 * opaque color.
 *
 * Other than various
 * <function>cairo_pattern_create_<emphasis>type</emphasis>()</function>
 * functions, some of the pattern types can be implicitly created using various
 * <function>cairo_set_source_<emphasis>type</emphasis>()</function> functions;
 * for example cairo_set_source_rgb().
 *
 * The type of a pattern can be queried with cairo_pattern_get_type().
 *
 * Memory management of #cairo_pattern_t is done with
 * cairo_pattern_reference() and cairo_pattern_destroy().
 *
 * Since: 1.0
 **)
  Pcairo_pattern_t = ^cairo_pattern_t;
  cairo_pattern_t = record
  end;

(**
 * cairo_destroy_func_t:
 * @data: The data element being destroyed.
 *
 * #cairo_destroy_func_t the type of function which is called when a
 * data element is destroyed. It is passed the pointer to the data
 * element and should free any memory and resources allocated for it.
 *
 * Since: 1.0
 **)
  cairo_destroy_func_t = procedure (data: pointer); cdecl;

(**
 * cairo_user_data_key_t:
 * @unused: not used; ignore.
 *
 * #cairo_user_data_key_t is used for attaching user data to cairo
 * data structures.  The actual contents of the struct is never used,
 * and there is no need to initialize the object; only the unique
 * address of a #cairo_data_key_t object is used.  Typically, you
 * would just use the address of a static #cairo_data_key_t object.
 *
 * Since: 1.0
 **)
  Pcairo_user_data_key_t = ^cairo_user_data_key_t;
  cairo_user_data_key_t = record
    unused: cint;
  end;

(**
 * cairo_status_t:
 * @CAIRO_STATUS_SUCCESS: no error has occurred (Since 1.0)
 * @CAIRO_STATUS_NO_MEMORY: out of memory (Since 1.0)
 * @CAIRO_STATUS_INVALID_RESTORE: cairo_restore() called without matching cairo_save() (Since 1.0)
 * @CAIRO_STATUS_INVALID_POP_GROUP: no saved group to pop, i.e. cairo_pop_group() without matching cairo_push_group() (Since 1.0)
 * @CAIRO_STATUS_NO_CURRENT_POINT: no current point defined (Since 1.0)
 * @CAIRO_STATUS_INVALID_MATRIX: invalid matrix (not invertible) (Since 1.0)
 * @CAIRO_STATUS_INVALID_STATUS: invalid value for an input #cairo_status_t (Since 1.0)
 * @CAIRO_STATUS_NULL_POINTER: %NULL pointer (Since 1.0)
 * @CAIRO_STATUS_INVALID_STRING: input string not valid UTF-8 (Since 1.0)
 * @CAIRO_STATUS_INVALID_PATH_DATA: input path data not valid (Since 1.0)
 * @CAIRO_STATUS_READ_ERROR: error while reading from input stream (Since 1.0)
 * @CAIRO_STATUS_WRITE_ERROR: error while writing to output stream (Since 1.0)
 * @CAIRO_STATUS_SURFACE_FINISHED: target surface has been finished (Since 1.0)
 * @CAIRO_STATUS_SURFACE_TYPE_MISMATCH: the surface type is not appropriate for the operation (Since 1.0)
 * @CAIRO_STATUS_PATTERN_TYPE_MISMATCH: the pattern type is not appropriate for the operation (Since 1.0)
 * @CAIRO_STATUS_INVALID_CONTENT: invalid value for an input #cairo_content_t (Since 1.0)
 * @CAIRO_STATUS_INVALID_FORMAT: invalid value for an input #cairo_format_t (Since 1.0)
 * @CAIRO_STATUS_INVALID_VISUAL: invalid value for an input Visual* (Since 1.0)
 * @CAIRO_STATUS_FILE_NOT_FOUND: file not found (Since 1.0)
 * @CAIRO_STATUS_INVALID_DASH: invalid value for a dash setting (Since 1.0)
 * @CAIRO_STATUS_INVALID_DSC_COMMENT: invalid value for a DSC comment (Since 1.2)
 * @CAIRO_STATUS_INVALID_INDEX: invalid index passed to getter (Since 1.4)
 * @CAIRO_STATUS_CLIP_NOT_REPRESENTABLE: clip region not representable in desired format (Since 1.4)
 * @CAIRO_STATUS_TEMP_FILE_ERROR: error creating or writing to a temporary file (Since 1.6)
 * @CAIRO_STATUS_INVALID_STRIDE: invalid value for stride (Since 1.6)
 * @CAIRO_STATUS_FONT_TYPE_MISMATCH: the font type is not appropriate for the operation (Since 1.8)
 * @CAIRO_STATUS_USER_FONT_IMMUTABLE: the user-font is immutable (Since 1.8)
 * @CAIRO_STATUS_USER_FONT_ERROR: error occurred in a user-font callback function (Since 1.8)
 * @CAIRO_STATUS_NEGATIVE_COUNT: negative number used where it is not allowed (Since 1.8)
 * @CAIRO_STATUS_INVALID_CLUSTERS: input clusters do not represent the accompanying text and glyph array (Since 1.8)
 * @CAIRO_STATUS_INVALID_SLANT: invalid value for an input #cairo_font_slant_t (Since 1.8)
 * @CAIRO_STATUS_INVALID_WEIGHT: invalid value for an input #cairo_font_weight_t (Since 1.8)
 * @CAIRO_STATUS_INVALID_SIZE: invalid value (typically too big) for the size of the input (surface, pattern, etc.) (Since 1.10)
 * @CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED: user-font method not implemented (Since 1.10)
 * @CAIRO_STATUS_DEVICE_TYPE_MISMATCH: the device type is not appropriate for the operation (Since 1.10)
 * @CAIRO_STATUS_DEVICE_ERROR: an operation to the device caused an unspecified error (Since 1.10)
 * @CAIRO_STATUS_INVALID_MESH_CONSTRUCTION: a mesh pattern
 *   construction operation was used outside of a
 *   cairo_mesh_pattern_begin_patch()/cairo_mesh_pattern_end_patch()
 *   pair (Since 1.12)
 * @CAIRO_STATUS_DEVICE_FINISHED: target device has been finished (Since 1.12)
 * @CAIRO_STATUS_JBIG2_GLOBAL_MISSING: %CAIRO_MIME_TYPE_JBIG2_GLOBAL_ID has been used on at least one image
 *   but no image provided %CAIRO_MIME_TYPE_JBIG2_GLOBAL (Since 1.14)
 * @CAIRO_STATUS_PNG_ERROR: error occurred in libpng while reading from or writing to a PNG file (Since 1.16)
 * @CAIRO_STATUS_FREETYPE_ERROR: error occurred in libfreetype (Since 1.16)
 * @CAIRO_STATUS_WIN32_GDI_ERROR: error occurred in the Windows Graphics Device Interface (Since 1.16)
 * @CAIRO_STATUS_TAG_ERROR: invalid tag name, attributes, or nesting (Since 1.16)
 * @CAIRO_STATUS_LAST_STATUS: this is a special value indicating the number of
 *   status values defined in this enumeration.  When using this value, note
 *   that the version of cairo at run-time may have additional status values
 *   defined than the value of this symbol at compile-time. (Since 1.10)
 *
 * #cairo_status_t is used to indicate errors that can occur when
 * using Cairo. In some cases it is returned directly by functions.
 * but when using #cairo_t, the last error, if any, is stored in
 * the context and can be retrieved with cairo_status().
 *
 * New entries may be added in future versions.  Use cairo_status_to_string()
 * to get a human-readable representation of an error message.
 *
 * Since: 1.0
 **)
  cairo_status_t = (
    CAIRO_STATUS_SUCCESS = 0,

    CAIRO_STATUS_NO_MEMORY,
    CAIRO_STATUS_INVALID_RESTORE,
    CAIRO_STATUS_INVALID_POP_GROUP,
    CAIRO_STATUS_NO_CURRENT_POINT,
    CAIRO_STATUS_INVALID_MATRIX,
    CAIRO_STATUS_INVALID_STATUS,
    CAIRO_STATUS_NULL_POINTER,
    CAIRO_STATUS_INVALID_STRING,
    CAIRO_STATUS_INVALID_PATH_DATA,
    CAIRO_STATUS_READ_ERROR,
    CAIRO_STATUS_WRITE_ERROR,
    CAIRO_STATUS_SURFACE_FINISHED,
    CAIRO_STATUS_SURFACE_TYPE_MISMATCH,
    CAIRO_STATUS_PATTERN_TYPE_MISMATCH,
    CAIRO_STATUS_INVALID_CONTENT,
    CAIRO_STATUS_INVALID_FORMAT,
    CAIRO_STATUS_INVALID_VISUAL,
    CAIRO_STATUS_FILE_NOT_FOUND,
    CAIRO_STATUS_INVALID_DASH,
    CAIRO_STATUS_INVALID_DSC_COMMENT,
    CAIRO_STATUS_INVALID_INDEX,
    CAIRO_STATUS_CLIP_NOT_REPRESENTABLE,
    CAIRO_STATUS_TEMP_FILE_ERROR,
    CAIRO_STATUS_INVALID_STRIDE,
    CAIRO_STATUS_FONT_TYPE_MISMATCH,
    CAIRO_STATUS_USER_FONT_IMMUTABLE,
    CAIRO_STATUS_USER_FONT_ERROR,
    CAIRO_STATUS_NEGATIVE_COUNT,
    CAIRO_STATUS_INVALID_CLUSTERS,
    CAIRO_STATUS_INVALID_SLANT,
    CAIRO_STATUS_INVALID_WEIGHT,
    CAIRO_STATUS_INVALID_SIZE,
    CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED,
    CAIRO_STATUS_DEVICE_TYPE_MISMATCH,
    CAIRO_STATUS_DEVICE_ERROR,
    CAIRO_STATUS_INVALID_MESH_CONSTRUCTION,
    CAIRO_STATUS_DEVICE_FINISHED,
    CAIRO_STATUS_JBIG2_GLOBAL_MISSING,
    CAIRO_STATUS_PNG_ERROR,
    CAIRO_STATUS_FREETYPE_ERROR,
    CAIRO_STATUS_WIN32_GDI_ERROR,
    CAIRO_STATUS_TAG_ERROR,

    CAIRO_STATUS_LAST_STATUS
  );

(**
 * cairo_content_t:
 * @CAIRO_CONTENT_COLOR: The surface will hold color content only. (Since 1.0)
 * @CAIRO_CONTENT_ALPHA: The surface will hold alpha content only. (Since 1.0)
 * @CAIRO_CONTENT_COLOR_ALPHA: The surface will hold color and alpha content. (Since 1.0)
 *
 * #cairo_content_t is used to describe the content that a surface will
 * contain, whether color information, alpha information (translucence
 * vs. opacity), or both.
 *
 * Note: The large values here are designed to keep #cairo_content_t
 * values distinct from #cairo_format_t values so that the
 * implementation can detect the error if users confuse the two types.
 *
 * Since: 1.0
 **)
  cairo_content_t = (
    CAIRO_CONTENT_COLOR       = $1000,
    CAIRO_CONTENT_ALPHA       = $2000,
    CAIRO_CONTENT_COLOR_ALPHA = $3000
  );

(**
 * cairo_format_t:
 * @CAIRO_FORMAT_INVALID: no such format exists or is supported.
 * @CAIRO_FORMAT_ARGB32: each pixel is a 32-bit quantity, with
 *   alpha in the upper 8 bits, then red, then green, then blue.
 *   The 32-bit quantities are stored native-endian. Pre-multiplied
 *   alpha is used. (That is, 50% transparent red is 0x80800000,
 *   not 0x80ff0000.) (Since 1.0)
 * @CAIRO_FORMAT_RGB24: each pixel is a 32-bit quantity, with
 *   the upper 8 bits unused. Red, Green, and Blue are stored
 *   in the remaining 24 bits in that order. (Since 1.0)
 * @CAIRO_FORMAT_A8: each pixel is a 8-bit quantity holding
 *   an alpha value. (Since 1.0)
 * @CAIRO_FORMAT_A1: each pixel is a 1-bit quantity holding
 *   an alpha value. Pixels are packed together into 32-bit
 *   quantities. The ordering of the bits matches the
 *   endianess of the platform. On a big-endian machine, the
 *   first pixel is in the uppermost bit, on a little-endian
 *   machine the first pixel is in the least-significant bit. (Since 1.0)
 * @CAIRO_FORMAT_RGB16_565: each pixel is a 16-bit quantity
 *   with red in the upper 5 bits, then green in the middle
 *   6 bits, and blue in the lower 5 bits. (Since 1.2)
 * @CAIRO_FORMAT_RGB30: like RGB24 but with 10bpc. (Since 1.12)
 *
 * #cairo_format_t is used to identify the memory format of
 * image data.
 *
 * New entries may be added in future versions.
 *
 * Since: 1.0
 **)
  cairo_format_t = (
    CAIRO_FORMAT_INVALID   = -1,
    CAIRO_FORMAT_ARGB32    = 0,
    CAIRO_FORMAT_RGB24     = 1,
    CAIRO_FORMAT_A8        = 2,
    CAIRO_FORMAT_A1        = 3,
    CAIRO_FORMAT_RGB16_565 = 4,
    CAIRO_FORMAT_RGB30     = 5
  );

(**
 * cairo_write_func_t:
 * @closure: the output closure
 * @data: the buffer containing the data to write
 * @length: the amount of data to write
 *
 * #cairo_write_func_t is the type of function which is called when a
 * backend needs to write data to an output stream.  It is passed the
 * closure which was specified by the user at the time the write
 * function was registered, the data to write and the length of the
 * data in bytes.  The write function should return
 * %CAIRO_STATUS_SUCCESS if all the data was successfully written,
 * %CAIRO_STATUS_WRITE_ERROR otherwise.
 *
 * Returns: the status code of the write operation
 *
 * Since: 1.0
 **)
  cairo_write_func_t = function (closure: pointer; const data: pcuchar; length: cuint): cairo_status_t; cdecl;

(**
 * cairo_read_func_t:
 * @closure: the input closure
 * @data: the buffer into which to read the data
 * @length: the amount of data to read
 *
 * #cairo_read_func_t is the type of function which is called when a
 * backend needs to read data from an input stream.  It is passed the
 * closure which was specified by the user at the time the read
 * function was registered, the buffer to read the data into and the
 * length of the data in bytes.  The read function should return
 * %CAIRO_STATUS_SUCCESS if all the data was successfully read,
 * %CAIRO_STATUS_READ_ERROR otherwise.
 *
 * Returns: the status code of the read operation
 *
 * Since: 1.0
 **)
  cairo_read_func_t = function (closure : pointer; data: pcuchar; length: cuint): cairo_status_t; cdecl;

(**
 * cairo_rectangle_int_t:
 * @x: X coordinate of the left side of the rectangle
 * @y: Y coordinate of the the top side of the rectangle
 * @width: width of the rectangle
 * @height: height of the rectangle
 *
 * A data structure for holding a rectangle with integer coordinates.
 *
 * Since: 1.10
 **)
  Pcairo_rectangle_int_t = ^cairo_rectangle_int_t;
  cairo_rectangle_int_t = record
    x, y: cint;
    width, height: cint;
  end;

(* Functions for manipulating state objects *)
function cairo_create(target: Pcairo_surface_t): Pcairo_t; cdecl; external LIB_CAIRO;

function cairo_reference(cr: Pcairo_t): Pcairo_t; cdecl; external LIB_CAIRO;

procedure cairo_destroy(cr: Pcairo_t); cdecl; external LIB_CAIRO;

function cairo_get_reference_count(cr: Pcairo_t): cuint; cdecl; external LIB_CAIRO;

function cairo_get_user_data(cr: Pcairo_t; const key: Pcairo_user_data_key_t): pointer; cdecl; external LIB_CAIRO;

function cairo_set_user_data(cr: Pcairo_t; const key: Pcairo_user_data_key_t; user_data: pointer; destroy_func: cairo_destroy_func_t): cairo_status_t; cdecl; external LIB_CAIRO;

procedure cairo_save(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_restore(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_push_group(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_push_group_with_content(cr: Pcairo_t; content: cairo_content_t); cdecl; external LIB_CAIRO;

function cairo_pop_group(cr: Pcairo_t): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

procedure cairo_pop_group_to_source(cr: Pcairo_t); cdecl; external LIB_CAIRO;

(* Modify state *)

type
(**
 * cairo_operator_t:
 * @CAIRO_OPERATOR_CLEAR: clear destination layer (bounded) (Since 1.0)
 * @CAIRO_OPERATOR_SOURCE: replace destination layer (bounded) (Since 1.0)
 * @CAIRO_OPERATOR_OVER: draw source layer on top of destination layer
 * (bounded) (Since 1.0)
 * @CAIRO_OPERATOR_IN: draw source where there was destination content
 * (unbounded) (Since 1.0)
 * @CAIRO_OPERATOR_OUT: draw source where there was no destination
 * content (unbounded) (Since 1.0)
 * @CAIRO_OPERATOR_ATOP: draw source on top of destination content and
 * only there (Since 1.0)
 * @CAIRO_OPERATOR_DEST: ignore the source (Since 1.0)
 * @CAIRO_OPERATOR_DEST_OVER: draw destination on top of source (Since 1.0)
 * @CAIRO_OPERATOR_DEST_IN: leave destination only where there was
 * source content (unbounded) (Since 1.0)
 * @CAIRO_OPERATOR_DEST_OUT: leave destination only where there was no
 * source content (Since 1.0)
 * @CAIRO_OPERATOR_DEST_ATOP: leave destination on top of source content
 * and only there (unbounded) (Since 1.0)
 * @CAIRO_OPERATOR_XOR: source and destination are shown where there is only
 * one of them (Since 1.0)
 * @CAIRO_OPERATOR_ADD: source and destination layers are accumulated (Since 1.0)
 * @CAIRO_OPERATOR_SATURATE: like over, but assuming source and dest are
 * disjoint geometries (Since 1.0)
 * @CAIRO_OPERATOR_MULTIPLY: source and destination layers are multiplied.
 * This causes the result to be at least as dark as the darker inputs. (Since 1.10)
 * @CAIRO_OPERATOR_SCREEN: source and destination are complemented and
 * multiplied. This causes the result to be at least as light as the lighter
 * inputs. (Since 1.10)
 * @CAIRO_OPERATOR_OVERLAY: multiplies or screens, depending on the
 * lightness of the destination color. (Since 1.10)
 * @CAIRO_OPERATOR_DARKEN: replaces the destination with the source if it
 * is darker, otherwise keeps the source. (Since 1.10)
 * @CAIRO_OPERATOR_LIGHTEN: replaces the destination with the source if it
 * is lighter, otherwise keeps the source. (Since 1.10)
 * @CAIRO_OPERATOR_COLOR_DODGE: brightens the destination color to reflect
 * the source color. (Since 1.10)
 * @CAIRO_OPERATOR_COLOR_BURN: darkens the destination color to reflect
 * the source color. (Since 1.10)
 * @CAIRO_OPERATOR_HARD_LIGHT: Multiplies or screens, dependent on source
 * color. (Since 1.10)
 * @CAIRO_OPERATOR_SOFT_LIGHT: Darkens or lightens, dependent on source
 * color. (Since 1.10)
 * @CAIRO_OPERATOR_DIFFERENCE: Takes the difference of the source and
 * destination color. (Since 1.10)
 * @CAIRO_OPERATOR_EXCLUSION: Produces an effect similar to difference, but
 * with lower contrast. (Since 1.10)
 * @CAIRO_OPERATOR_HSL_HUE: Creates a color with the hue of the source
 * and the saturation and luminosity of the target. (Since 1.10)
 * @CAIRO_OPERATOR_HSL_SATURATION: Creates a color with the saturation
 * of the source and the hue and luminosity of the target. Painting with
 * this mode onto a gray area produces no change. (Since 1.10)
 * @CAIRO_OPERATOR_HSL_COLOR: Creates a color with the hue and saturation
 * of the source and the luminosity of the target. This preserves the gray
 * levels of the target and is useful for coloring monochrome images or
 * tinting color images. (Since 1.10)
 * @CAIRO_OPERATOR_HSL_LUMINOSITY: Creates a color with the luminosity of
 * the source and the hue and saturation of the target. This produces an
 * inverse effect to @CAIRO_OPERATOR_HSL_COLOR. (Since 1.10)
 *
 * #cairo_operator_t is used to set the compositing operator for all cairo
 * drawing operations.
 *
 * The default operator is %CAIRO_OPERATOR_OVER.
 *
 * The operators marked as <firstterm>unbounded</firstterm> modify their
 * destination even outside of the mask layer (that is, their effect is not
 * bound by the mask layer).  However, their effect can still be limited by
 * way of clipping.
 *
 * To keep things simple, the operator descriptions here
 * document the behavior for when both source and destination are either fully
 * transparent or fully opaque.  The actual implementation works for
 * translucent layers too.
 * For a more detailed explanation of the effects of each operator, including
 * the mathematical definitions, see
 * <ulink url="http://cairographics.org/operators/">http://cairographics.org/operators/</ulink>.
 *
 * Since: 1.0
 **)
  cairo_operator_t = (
    CAIRO_OPERATOR_CLEAR,

    CAIRO_OPERATOR_SOURCE,
    CAIRO_OPERATOR_OVER,
    CAIRO_OPERATOR_IN,
    CAIRO_OPERATOR_OUT,
    CAIRO_OPERATOR_ATOP,

    CAIRO_OPERATOR_DEST,
    CAIRO_OPERATOR_DEST_OVER,
    CAIRO_OPERATOR_DEST_IN,
    CAIRO_OPERATOR_DEST_OUT,
    CAIRO_OPERATOR_DEST_ATOP,

    CAIRO_OPERATOR_XOR,
    CAIRO_OPERATOR_ADD,
    CAIRO_OPERATOR_SATURATE,

    CAIRO_OPERATOR_MULTIPLY,
    CAIRO_OPERATOR_SCREEN,
    CAIRO_OPERATOR_OVERLAY,
    CAIRO_OPERATOR_DARKEN,
    CAIRO_OPERATOR_LIGHTEN,
    CAIRO_OPERATOR_COLOR_DODGE,
    CAIRO_OPERATOR_COLOR_BURN,
    CAIRO_OPERATOR_HARD_LIGHT,
    CAIRO_OPERATOR_SOFT_LIGHT,
    CAIRO_OPERATOR_DIFFERENCE,
    CAIRO_OPERATOR_EXCLUSION,
    CAIRO_OPERATOR_HSL_HUE,
    CAIRO_OPERATOR_HSL_SATURATION,
    CAIRO_OPERATOR_HSL_COLOR,
    CAIRO_OPERATOR_HSL_LUMINOSITY
  );

procedure cairo_set_operator(cr: Pcairo_t; op: cairo_operator_t); cdecl; external LIB_CAIRO;

procedure cairo_set_source(cr: Pcairo_t; source: Pcairo_pattern_t); cdecl; external LIB_CAIRO;

procedure cairo_set_source_rgb(cr: Pcairo_t; red: cdouble; green: cdouble; blue: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_set_source_rgba(cr: Pcairo_t; red: cdouble; green: cdouble; blue: cdouble; alpha: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_set_source_surface(cr: Pcairo_t; surface: Pcairo_surface_t; x: cdouble; y: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_set_tolerance(cr: Pcairo_t; tolerance: cdouble); cdecl; external LIB_CAIRO;

type
(**
 * cairo_antialias_t:
 * @CAIRO_ANTIALIAS_DEFAULT: Use the default antialiasing for
 *   the subsystem and target device, since 1.0
 * @CAIRO_ANTIALIAS_NONE: Use a bilevel alpha mask, since 1.0
 * @CAIRO_ANTIALIAS_GRAY: Perform single-color antialiasing (using
 *  shades of gray for black text on a white background, for example), since 1.0
 * @CAIRO_ANTIALIAS_SUBPIXEL: Perform antialiasing by taking
 *  advantage of the order of subpixel elements on devices
 *  such as LCD panels, since 1.0
 * @CAIRO_ANTIALIAS_FAST: Hint that the backend should perform some
 * antialiasing but prefer speed over quality, since 1.12
 * @CAIRO_ANTIALIAS_GOOD: The backend should balance quality against
 * performance, since 1.12
 * @CAIRO_ANTIALIAS_BEST: Hint that the backend should render at the highest
 * quality, sacrificing speed if necessary, since 1.12
 *
 * Specifies the type of antialiasing to do when rendering text or shapes.
 *
 * As it is not necessarily clear from the above what advantages a particular
 * antialias method provides, since 1.12, there is also a set of hints:
 * @CAIRO_ANTIALIAS_FAST: Allow the backend to degrade raster quality for speed
 * @CAIRO_ANTIALIAS_GOOD: A balance between speed and quality
 * @CAIRO_ANTIALIAS_BEST: A high-fidelity, but potentially slow, raster mode
 *
 * These make no guarantee on how the backend will perform its rasterisation
 * (if it even rasterises!), nor that they have any differing effect other
 * than to enable some form of antialiasing. In the case of glyph rendering,
 * @CAIRO_ANTIALIAS_FAST and @CAIRO_ANTIALIAS_GOOD will be mapped to
 * @CAIRO_ANTIALIAS_GRAY, with @CAIRO_ANTALIAS_BEST being equivalent to
 * @CAIRO_ANTIALIAS_SUBPIXEL.
 *
 * The interpretation of @CAIRO_ANTIALIAS_DEFAULT is left entirely up to
 * the backend, typically this will be similar to @CAIRO_ANTIALIAS_GOOD.
 *
 * Since: 1.0
 **)
  cairo_antialias_t = (
    CAIRO_ANTIALIAS_DEFAULT,

    (* method *)
    CAIRO_ANTIALIAS_NONE,
    CAIRO_ANTIALIAS_GRAY,
    CAIRO_ANTIALIAS_SUBPIXEL,

    (* hints *)
    CAIRO_ANTIALIAS_FAST,
    CAIRO_ANTIALIAS_GOOD,
    CAIRO_ANTIALIAS_BEST
  );

procedure cairo_set_antialias(cr: Pcairo_t; antialias: cairo_antialias_t); cdecl; external LIB_CAIRO;

type
(**
 * cairo_fill_rule_t:
 * @CAIRO_FILL_RULE_WINDING: If the path crosses the ray from
 * left-to-right, counts +1. If the path crosses the ray
 * from right to left, counts -1. (Left and right are determined
 * from the perspective of looking along the ray from the starting
 * point.) If the total count is non-zero, the point will be filled. (Since 1.0)
 * @CAIRO_FILL_RULE_EVEN_ODD: Counts the total number of
 * intersections, without regard to the orientation of the contour. If
 * the total number of intersections is odd, the point will be
 * filled. (Since 1.0)
 *
 * #cairo_fill_rule_t is used to select how paths are filled. For both
 * fill rules, whether or not a point is included in the fill is
 * determined by taking a ray from that point to infinity and looking
 * at intersections with the path. The ray can be in any direction,
 * as long as it doesn't pass through the end point of a segment
 * or have a tricky intersection such as intersecting tangent to the path.
 * (Note that filling is not actually implemented in this way. This
 * is just a description of the rule that is applied.)
 *
 * The default fill rule is %CAIRO_FILL_RULE_WINDING.
 *
 * New entries may be added in future versions.
 *
 * Since: 1.0
 **)
  cairo_fill_rule_t = (
    CAIRO_FILL_RULE_WINDING,
    CAIRO_FILL_RULE_EVEN_ODD
  );

procedure cairo_set_fill_rule(cr: Pcairo_t; fill_rule: cairo_fill_rule_t); cdecl; external LIB_CAIRO;

procedure cairo_set_line_width(cr: Pcairo_t; width: cdouble); cdecl; external LIB_CAIRO;

type
(**
 * cairo_line_cap_t:
 * @CAIRO_LINE_CAP_BUTT: start(stop) the line exactly at the start(end) point (Since 1.0)
 * @CAIRO_LINE_CAP_ROUND: use a round ending, the center of the circle is the end point (Since 1.0)
 * @CAIRO_LINE_CAP_SQUARE: use squared ending, the center of the square is the end point (Since 1.0)
 *
 * Specifies how to render the endpoints of the path when stroking.
 *
 * The default line cap style is %CAIRO_LINE_CAP_BUTT.
 *
 * Since: 1.0
 **)
  cairo_line_cap_t = (
    CAIRO_LINE_CAP_BUTT,
    CAIRO_LINE_CAP_ROUND,
    CAIRO_LINE_CAP_SQUARE
  );

procedure cairo_set_line_cap(cr: Pcairo_t; line_cap: cairo_line_cap_t); cdecl; external LIB_CAIRO;

type
(**
 * cairo_line_join_t:
 * @CAIRO_LINE_JOIN_MITER: use a sharp (angled) corner, see
 * cairo_set_miter_limit() (Since 1.0)
 * @CAIRO_LINE_JOIN_ROUND: use a rounded join, the center of the circle is the
 * joint point (Since 1.0)
 * @CAIRO_LINE_JOIN_BEVEL: use a cut-off join, the join is cut off at half
 * the line width from the joint point (Since 1.0)
 *
 * Specifies how to render the junction of two lines when stroking.
 *
 * The default line join style is %CAIRO_LINE_JOIN_MITER.
 *
 * Since: 1.0
 **)
  cairo_line_join_t = (
    CAIRO_LINE_JOIN_MITER,
    CAIRO_LINE_JOIN_ROUND,
    CAIRO_LINE_JOIN_BEVEL
  );

procedure cairo_set_line_join(cr: Pcairo_t; line_join: cairo_line_join_t); cdecl; external LIB_CAIRO;

procedure cairo_set_dash(cr: Pcairo_t; const dashes: pcdouble; num_dashes: cint; offset: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_set_miter_limit(cr: Pcairo_t; limit: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_translate(cr: Pcairo_t; tx: cdouble; ty: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_scale(cr: Pcairo_t; sx: cdouble; sy: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_rotate(cr: Pcairo_t; angle: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_transform(cr: Pcairo_t; const matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_set_matrix(cr: Pcairo_t; const matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_identity_matrix(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_user_to_device(cr: Pcairo_t; x: pcdouble; y: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_user_to_device_distance(cr: Pcairo_t; dx: pcdouble; dy: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_device_to_user(cr: Pcairo_t; x: pcdouble; y: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_device_to_user_distance(cr: Pcairo_t; dx: pcdouble; dy: pcdouble); cdecl; external LIB_CAIRO;

(* Path creation functions *)
procedure cairo_new_path(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_move_to(cr: Pcairo_t; x: cdouble; y: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_new_sub_path(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_line_to(cr: Pcairo_t; x: cdouble; y: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_curve_to(cr: Pcairo_t; x1: cdouble; y1: cdouble; x2: cdouble; y2: cdouble; x3: cdouble; y3: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_arc(cr: Pcairo_t; xc: cdouble; yc: cdouble; radius: cdouble; angle1: cdouble; angle2: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_arc_negative(cr: Pcairo_t; xc: cdouble; yc: cdouble; radius: cdouble; angle1: cdouble; angle2: cdouble); cdecl; external LIB_CAIRO;

(* XXX: NYI
procedure cairo_arc_to(cr: Pcairo_t; x1: cdouble; y1: cdouble; x2: cdouble; y2: cdouble; radius: cdouble); cdecl; external LIB_CAIRO;
*)

procedure cairo_rel_move_to(cr: Pcairo_t; dx: cdouble; dy: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_rel_line_to(cr: Pcairo_t; dx: cdouble; dy: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_rel_curve_to(cr: Pcairo_t; dx1: cdouble; dy1: cdouble; dx2: cdouble; dy2: cdouble; dx3: cdouble; dy3: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_rectangle(cr: Pcairo_t; x: cdouble; y: cdouble; width: cdouble; height: cdouble); cdecl; external LIB_CAIRO;

(* XXX: NYI
procedure cairo_stroke_to_path(cr: Pcairo_t); cdecl; external LIB_CAIRO;
*)

procedure cairo_close_path(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_path_extents(cr: Pcairo_t; x1: pcdouble; y1: pcdouble; x2: pcdouble; y2: pcdouble); cdecl; external LIB_CAIRO;

(* Painting functions *)

procedure cairo_paint(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_paint_with_alpha(cr: Pcairo_t; alpha: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_mask(cr: Pcairo_t; pattern: Pcairo_pattern_t); cdecl; external LIB_CAIRO;

procedure cairo_mask_surface(cr: Pcairo_t; surface: Pcairo_surface_t; surface_x: cdouble; surface_y: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_stroke(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_stroke_preserve(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_fill(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_fill_preserve(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_copy_page(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_show_page(cr: Pcairo_t); cdecl; external LIB_CAIRO;

(* Insideness testing *)

function cairo_in_stroke(cr: Pcairo_t; x: cdouble; y: cdouble): cairo_bool_t; cdecl; external LIB_CAIRO;

function cairo_in_fill(cr: Pcairo_t; x: cdouble; y: cdouble): cairo_bool_t; cdecl; external LIB_CAIRO;

function cairo_in_clip(cr: Pcairo_t; x: cdouble; y: cdouble): cairo_bool_t; cdecl; external LIB_CAIRO;

(* Rectangular extents *)

procedure cairo_stroke_extents(cr: Pcairo_t; x1: pcdouble; y1: pcdouble; x2: pcdouble; y2: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_fill_extents(cr: Pcairo_t; x1: pcdouble; y1: pcdouble; x2: pcdouble; y2: pcdouble); cdecl; external LIB_CAIRO;

(* Clipping *)

procedure cairo_reset_clip(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_clip(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_clip_preserve(cr: Pcairo_t); cdecl; external LIB_CAIRO;

procedure cairo_clip_extents(cr: Pcairo_t; x1: pcdouble; y1: pcdouble; x2: pcdouble; y2: pcdouble); cdecl; external LIB_CAIRO;

type
(**
 * cairo_rectangle_t:
 * @x: X coordinate of the left side of the rectangle
 * @y: Y coordinate of the the top side of the rectangle
 * @width: width of the rectangle
 * @height: height of the rectangle
 *
 * A data structure for holding a rectangle.
 *
 * Since: 1.4
 **)
  Pcairo_rectangle_t = ^cairo_rectangle_t;
  cairo_rectangle_t = record
    x, y, width, height: cdouble;
  end;

(**
 * cairo_rectangle_list_t:
 * @status: Error status of the rectangle list
 * @rectangles: Array containing the rectangles
 * @num_rectangles: Number of rectangles in this list
 * 
 * A data structure for holding a dynamically allocated
 * array of rectangles.
 *
 * Since: 1.4
 **)
  Pcairo_rectangle_list_t = ^cairo_rectangle_list_t;
  cairo_rectangle_list_t = record
    status: cairo_status_t;
    rectangles: Pcairo_rectangle_t;
    num_rectangles: cint;
  end;

function cairo_copy_clip_rectangle_list(cr: Pcairo_t): Pcairo_rectangle_list_t; cdecl; external LIB_CAIRO;

procedure cairo_rectangle_list_destroy(rectangle_list: Pcairo_rectangle_list_t); cdecl; external LIB_CAIRO;

(* Logical structure tagging functions *)

const
  CAIRO_TAG_DEST = 'cairo.dest';
  CAIRO_TAG_LINK = 'Link';

procedure cairo_tag_begin(cr: Pcairo_t; const tag_name: pchar; const attributes: pchar); cdecl; external LIB_CAIRO;

procedure cairo_tag_end(cr: Pcairo_t; const tag_name: pchar); cdecl; external LIB_CAIRO;

(* Font/Text functions *)

type
(**
 * cairo_scaled_font_t:
 *
 * A #cairo_scaled_font_t is a font scaled to a particular size and device
 * resolution. A #cairo_scaled_font_t is most useful for low-level font
 * usage where a library or application wants to cache a reference
 * to a scaled font to speed up the computation of metrics.
 *
 * There are various types of scaled fonts, depending on the
 * <firstterm>font backend</firstterm> they use. The type of a
 * scaled font can be queried using cairo_scaled_font_get_type().
 *
 * Memory management of #cairo_scaled_font_t is done with
 * cairo_scaled_font_reference() and cairo_scaled_font_destroy().
 *
 * Since: 1.0
 **)
  Pcairo_scaled_font_t = ^cairo_scaled_font_t;
  cairo_scaled_font_t = record
  end;

(**
 * cairo_font_face_t:
 *
 * A #cairo_font_face_t specifies all aspects of a font other
 * than the size or font matrix (a font matrix is used to distort
 * a font by sheering it or scaling it unequally in the two
 * directions) . A font face can be set on a #cairo_t by using
 * cairo_set_font_face(); the size and font matrix are set with
 * cairo_set_font_size() and cairo_set_font_matrix().
 *
 * There are various types of font faces, depending on the
 * <firstterm>font backend</firstterm> they use. The type of a
 * font face can be queried using cairo_font_face_get_type().
 *
 * Memory management of #cairo_font_face_t is done with
 * cairo_font_face_reference() and cairo_font_face_destroy().
 *
 * Since: 1.0
 **)
  Pcairo_font_face_t = ^cairo_font_face_t;
  cairo_font_face_t = record
  end;

(**
 * cairo_glyph_t:
 * @index: glyph index in the font. The exact interpretation of the
 *      glyph index depends on the font technology being used.
 * @x: the offset in the X direction between the origin used for
 *     drawing or measuring the string and the origin of this glyph.
 * @y: the offset in the Y direction between the origin used for
 *     drawing or measuring the string and the origin of this glyph.
 *
 * The #cairo_glyph_t structure holds information about a single glyph
 * when drawing or measuring text. A font is (in simple terms) a
 * collection of shapes used to draw text. A glyph is one of these
 * shapes. There can be multiple glyphs for a single character
 * (alternates to be used in different contexts, for example), or a
 * glyph can be a <firstterm>ligature</firstterm> of multiple
 * characters. Cairo doesn't expose any way of converting input text
 * into glyphs, so in order to use the Cairo interfaces that take
 * arrays of glyphs, you must directly access the appropriate
 * underlying font system.
 *
 * Note that the offsets given by @x and @y are not cumulative. When
 * drawing or measuring text, each glyph is individually positioned
 * with respect to the overall origin
 *
 * Since: 1.0
 **)
  Pcairo_glyph_t = ^cairo_glyph_t;
  PPcairo_glyph_t = ^Pcairo_glyph_t;
  cairo_glyph_t = record
    index: cuint;
    x: cdouble;
    y: cdouble;
  end;

function cairo_glyph_allocate(num_glyphs: cint): Pcairo_glyph_t; cdecl; external LIB_CAIRO;

procedure cairo_glyph_free(glyphs: Pcairo_glyph_t); cdecl; external LIB_CAIRO;

type
(**
 * cairo_text_cluster_t:
 * @num_bytes: the number of bytes of UTF-8 text covered by cluster
 * @num_glyphs: the number of glyphs covered by cluster
 *
 * The #cairo_text_cluster_t structure holds information about a single
 * <firstterm>text cluster</firstterm>.  A text cluster is a minimal
 * mapping of some glyphs corresponding to some UTF-8 text.
 *
 * For a cluster to be valid, both @num_bytes and @num_glyphs should
 * be non-negative, and at least one should be non-zero.
 * Note that clusters with zero glyphs are not as well supported as
 * normal clusters.  For example, PDF rendering applications typically
 * ignore those clusters when PDF text is being selected.
 *
 * See cairo_show_text_glyphs() for how clusters are used in advanced
 * text operations.
 *
 * Since: 1.8
 **)
  Pcairo_text_cluster_t = ^cairo_text_cluster_t;
  PPcairo_text_cluster_t = Pcairo_text_cluster_t;
  cairo_text_cluster_t = record
    num_bytes: cint;
    num_glyphs: cint;
  end;

function cairo_text_cluster_allocate(num_clusters: cint): Pcairo_text_cluster_t; cdecl; external LIB_CAIRO;

procedure cairo_text_cluster_free(clusters: Pcairo_text_cluster_t); cdecl; external LIB_CAIRO;

type
(**
 * cairo_text_cluster_flags_t:
 * @CAIRO_TEXT_CLUSTER_FLAG_BACKWARD: The clusters in the cluster array
 * map to glyphs in the glyph array from end to start. (Since 1.8)
 *
 * Specifies properties of a text cluster mapping.
 *
 * Since: 1.8
 **)
  Pcairo_text_cluster_flags_t = ^cairo_text_cluster_flags_t;
  cairo_text_cluster_flags_t = (
    CAIRO_TEXT_CLUSTER_FLAG_BACKWARD = $00000001
  );

(**
 * cairo_text_extents_t:
 * @x_bearing: the horizontal distance from the origin to the
 *   leftmost part of the glyphs as drawn. Positive if the
 *   glyphs lie entirely to the right of the origin.
 * @y_bearing: the vertical distance from the origin to the
 *   topmost part of the glyphs as drawn. Positive only if the
 *   glyphs lie completely below the origin; will usually be
 *   negative.
 * @width: width of the glyphs as drawn
 * @height: height of the glyphs as drawn
 * @x_advance:distance to advance in the X direction
 *    after drawing these glyphs
 * @y_advance: distance to advance in the Y direction
 *   after drawing these glyphs. Will typically be zero except
 *   for vertical text layout as found in East-Asian languages.
 *
 * The #cairo_text_extents_t structure stores the extents of a single
 * glyph or a string of glyphs in user-space coordinates. Because text
 * extents are in user-space coordinates, they are mostly, but not
 * entirely, independent of the current transformation matrix. If you call
 * <literal>cairo_scale(cr, 2.0, 2.0)</literal>, text will
 * be drawn twice as big, but the reported text extents will not be
 * doubled. They will change slightly due to hinting (so you can't
 * assume that metrics are independent of the transformation matrix),
 * but otherwise will remain unchanged.
 *
 * Since: 1.0
 **)
  Pcairo_text_extents_t = ^cairo_text_extents_t;
  cairo_text_extents_t = record
    x_bearing: cdouble;
    y_bearing: cdouble;
    width: cdouble;
    height: cdouble;
    x_advance: cdouble;
    y_advance: cdouble;
  end;

(**
 * cairo_font_extents_t:
 * @ascent: the distance that the font extends above the baseline.
 *          Note that this is not always exactly equal to the maximum
 *          of the extents of all the glyphs in the font, but rather
 *          is picked to express the font designer's intent as to
 *          how the font should align with elements above it.
 * @descent: the distance that the font extends below the baseline.
 *           This value is positive for typical fonts that include
 *           portions below the baseline. Note that this is not always
 *           exactly equal to the maximum of the extents of all the
 *           glyphs in the font, but rather is picked to express the
 *           font designer's intent as to how the font should
 *           align with elements below it.
 * @height: the recommended vertical distance between baselines when
 *          setting consecutive lines of text with the font. This
 *          is greater than @ascent+@descent by a
 *          quantity known as the <firstterm>line spacing</firstterm>
 *          or <firstterm>external leading</firstterm>. When space
 *          is at a premium, most fonts can be set with only
 *          a distance of @ascent+@descent between lines.
 * @max_x_advance: the maximum distance in the X direction that
 *         the origin is advanced for any glyph in the font.
 * @max_y_advance: the maximum distance in the Y direction that
 *         the origin is advanced for any glyph in the font.
 *         This will be zero for normal fonts used for horizontal
 *         writing. (The scripts of East Asia are sometimes written
 *         vertically.)
 *
 * The #cairo_font_extents_t structure stores metric information for
 * a font. Values are given in the current user-space coordinate
 * system.
 *
 * Because font metrics are in user-space coordinates, they are
 * mostly, but not entirely, independent of the current transformation
 * matrix. If you call <literal>cairo_scale(cr, 2.0, 2.0)</literal>,
 * text will be drawn twice as big, but the reported text extents will
 * not be doubled. They will change slightly due to hinting (so you
 * can't assume that metrics are independent of the transformation
 * matrix), but otherwise will remain unchanged.
 *
 * Since: 1.0
 **)
  Pcairo_font_extents_t = ^cairo_font_extents_t;
  cairo_font_extents_t = record
    ascent: cdouble;
    descent: cdouble;
    height: cdouble;
    max_x_advance: cdouble;
    max_y_advance: cdouble;
  end;

(**
 * cairo_font_slant_t:
 * @CAIRO_FONT_SLANT_NORMAL: Upright font style, since 1.0
 * @CAIRO_FONT_SLANT_ITALIC: Italic font style, since 1.0
 * @CAIRO_FONT_SLANT_OBLIQUE: Oblique font style, since 1.0
 *
 * Specifies variants of a font face based on their slant.
 *
 * Since: 1.0
 **)
  cairo_font_slant_t = (
    CAIRO_FONT_SLANT_NORMAL,
    CAIRO_FONT_SLANT_ITALIC,
    CAIRO_FONT_SLANT_OBLIQUE
  );

(**
 * cairo_font_weight_t:
 * @CAIRO_FONT_WEIGHT_NORMAL: Normal font weight, since 1.0
 * @CAIRO_FONT_WEIGHT_BOLD: Bold font weight, since 1.0
 *
 * Specifies variants of a font face based on their weight.
 *
 * Since: 1.0
 **)
  cairo_font_weight_t = (
    CAIRO_FONT_WEIGHT_NORMAL,
    CAIRO_FONT_WEIGHT_BOLD
  );

(**
 * cairo_subpixel_order_t:
 * @CAIRO_SUBPIXEL_ORDER_DEFAULT: Use the default subpixel order for
 *   for the target device, since 1.0
 * @CAIRO_SUBPIXEL_ORDER_RGB: Subpixel elements are arranged horizontally
 *   with red at the left, since 1.0
 * @CAIRO_SUBPIXEL_ORDER_BGR:  Subpixel elements are arranged horizontally
 *   with blue at the left, since 1.0
 * @CAIRO_SUBPIXEL_ORDER_VRGB: Subpixel elements are arranged vertically
 *   with red at the top, since 1.0
 * @CAIRO_SUBPIXEL_ORDER_VBGR: Subpixel elements are arranged vertically
 *   with blue at the top, since 1.0
 *
 * The subpixel order specifies the order of color elements within
 * each pixel on the display device when rendering with an
 * antialiasing mode of %CAIRO_ANTIALIAS_SUBPIXEL.
 *
 * Since: 1.0
 **)
  cairo_subpixel_order_t = (
    CAIRO_SUBPIXEL_ORDER_DEFAULT,
    CAIRO_SUBPIXEL_ORDER_RGB,
    CAIRO_SUBPIXEL_ORDER_BGR,
    CAIRO_SUBPIXEL_ORDER_VRGB,
    CAIRO_SUBPIXEL_ORDER_VBGR
  );

(**
 * cairo_hint_style_t:
 * @CAIRO_HINT_STYLE_DEFAULT: Use the default hint style for
 *   font backend and target device, since 1.0
 * @CAIRO_HINT_STYLE_NONE: Do not hint outlines, since 1.0
 * @CAIRO_HINT_STYLE_SLIGHT: Hint outlines slightly to improve
 *   contrast while retaining good fidelity to the original
 *   shapes, since 1.0
 * @CAIRO_HINT_STYLE_MEDIUM: Hint outlines with medium strength
 *   giving a compromise between fidelity to the original shapes
 *   and contrast, since 1.0
 * @CAIRO_HINT_STYLE_FULL: Hint outlines to maximize contrast, since 1.0
 *
 * Specifies the type of hinting to do on font outlines. Hinting
 * is the process of fitting outlines to the pixel grid in order
 * to improve the appearance of the result. Since hinting outlines
 * involves distorting them, it also reduces the faithfulness
 * to the original outline shapes. Not all of the outline hinting
 * styles are supported by all font backends.
 *
 * New entries may be added in future versions.
 *
 * Since: 1.0
 **)
  cairo_hint_style_t = (
    CAIRO_HINT_STYLE_DEFAULT,
    CAIRO_HINT_STYLE_NONE,
    CAIRO_HINT_STYLE_SLIGHT,
    CAIRO_HINT_STYLE_MEDIUM,
    CAIRO_HINT_STYLE_FULL
  );

(**
 * cairo_hint_metrics_t:
 * @CAIRO_HINT_METRICS_DEFAULT: Hint metrics in the default
 *  manner for the font backend and target device, since 1.0
 * @CAIRO_HINT_METRICS_OFF: Do not hint font metrics, since 1.0
 * @CAIRO_HINT_METRICS_ON: Hint font metrics, since 1.0
 *
 * Specifies whether to hint font metrics; hinting font metrics
 * means quantizing them so that they are integer values in
 * device space. Doing this improves the consistency of
 * letter and line spacing, however it also means that text
 * will be laid out differently at different zoom factors.
 *
 * Since: 1.0
 **)
  cairo_hint_metrics_t = (
    CAIRO_HINT_METRICS_DEFAULT,
    CAIRO_HINT_METRICS_OFF,
    CAIRO_HINT_METRICS_ON
  );

(**
 * cairo_font_options_t:
 *
 * An opaque structure holding all options that are used when
 * rendering fonts.
 *
 * Individual features of a #cairo_font_options_t can be set or
 * accessed using functions named
 * <function>cairo_font_options_set_<emphasis>feature_name</emphasis>()</function> and
 * <function>cairo_font_options_get_<emphasis>feature_name</emphasis>()</function>, like
 * cairo_font_options_set_antialias() and
 * cairo_font_options_get_antialias().
 *
 * New features may be added to a #cairo_font_options_t in the
 * future.  For this reason, cairo_font_options_copy(),
 * cairo_font_options_equal(), cairo_font_options_merge(), and
 * cairo_font_options_hash() should be used to copy, check
 * for equality, merge, or compute a hash value of
 * #cairo_font_options_t objects.
 *
 * Since: 1.0
 **)
  Pcairo_font_options_t = ^cairo_font_options_t;
  cairo_font_options_t = record
  end;

function cairo_font_options_create(): Pcairo_font_options_t; cdecl; external LIB_CAIRO;

function cairo_font_options_copy(const original: Pcairo_font_options_t): Pcairo_font_options_t; cdecl; external LIB_CAIRO;

procedure cairo_font_options_destroy(options: Pcairo_font_options_t); cdecl; external LIB_CAIRO;

function cairo_font_options_status(options: Pcairo_font_options_t): cairo_status_t; cdecl; external LIB_CAIRO;

procedure cairo_font_options_merge(options: Pcairo_font_options_t ; const other: Pcairo_font_options_t); cdecl; external LIB_CAIRO;

function cairo_font_options_equal(const options: Pcairo_font_options_t; const other: Pcairo_font_options_t): cairo_bool_t; cdecl; external LIB_CAIRO;

function cairo_font_options_hash(const options: Pcairo_font_options_t): cuint; cdecl; external LIB_CAIRO;

procedure cairo_font_options_set_antialias(options: Pcairo_font_options_t; antialias: cairo_antialias_t); cdecl; external LIB_CAIRO;

function cairo_font_options_get_antialias(const options: Pcairo_font_options_t): cairo_antialias_t; cdecl; external LIB_CAIRO;

procedure cairo_font_options_set_subpixel_order(options: Pcairo_font_options_t; subpixel_order: cairo_subpixel_order_t); cdecl; external LIB_CAIRO;

function cairo_font_options_get_subpixel_order(const options: Pcairo_font_options_t): cairo_subpixel_order_t; cdecl; external LIB_CAIRO;

procedure cairo_font_options_set_hint_style(options: Pcairo_font_options_t; hint_style: cairo_hint_style_t); cdecl; external LIB_CAIRO;

function cairo_font_options_get_hint_style(const options: Pcairo_font_options_t): cairo_hint_style_t; cdecl; external LIB_CAIRO;

procedure cairo_font_options_set_hint_metrics(options: Pcairo_font_options_t; hint_metrics: cairo_hint_metrics_t); cdecl; external LIB_CAIRO;

function cairo_font_options_get_hint_metrics(const options: Pcairo_font_options_t): cairo_hint_metrics_t; cdecl; external LIB_CAIRO;

(* This interface is for dealing with text as text, not caring about the font object inside the the cairo_t. *)

procedure cairo_select_font_face(cr: Pcairo_t; const family: pchar; slant: cairo_font_slant_t; weight: cairo_font_weight_t); cdecl; external LIB_CAIRO;

procedure cairo_set_font_size(cr: Pcairo_t; size: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_set_font_matrix(cr: Pcairo_t; const matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_get_font_matrix(cr: Pcairo_t; matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_set_font_options(cr: Pcairo_t; const options: Pcairo_font_options_t); cdecl; external LIB_CAIRO;

procedure cairo_get_font_options(cr: Pcairo_t; options: Pcairo_font_options_t); cdecl; external LIB_CAIRO;

procedure cairo_set_font_face(cr: Pcairo_t; font_face: Pcairo_font_face_t); cdecl; external LIB_CAIRO;

function cairo_get_font_face(cr: Pcairo_t): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

procedure cairo_set_scaled_font(cr: Pcairo_t; const scaled_font: Pcairo_scaled_font_t); cdecl; external LIB_CAIRO;

function cairo_get_scaled_font(cr: Pcairo_t): Pcairo_scaled_font_t; cdecl; external LIB_CAIRO;

procedure cairo_show_text(cr: Pcairo_t; const utf8: pchar); cdecl; external LIB_CAIRO;

procedure cairo_show_glyphs(cr: Pcairo_t; const glyphs: Pcairo_glyph_t; num_glyphs: cint); cdecl; external LIB_CAIRO;

procedure cairo_show_text_glyphs(cr: Pcairo_t; const utf8: pchar; utf8_len: cint; const glyphs: Pcairo_glyph_t; num_glyphs: cint; const clusters: Pcairo_text_cluster_t; num_clusters: cint; cluster_flags: cairo_text_cluster_flags_t); cdecl; external LIB_CAIRO;

procedure cairo_text_path(cr: Pcairo_t; const utf8: pchar); cdecl; external LIB_CAIRO;

procedure cairo_glyph_path(cr: Pcairo_t; const glyphs: Pcairo_glyph_t; num_glyphs: cint); cdecl; external LIB_CAIRO;

procedure cairo_text_extents(cr: Pcairo_t; const utf8: pchar; extents: Pcairo_text_extents_t); cdecl; external LIB_CAIRO;

procedure cairo_glyph_extents(cr: Pcairo_t; const glyphs: Pcairo_glyph_t; num_glyphs: cint; extents: Pcairo_text_extents_t); cdecl; external LIB_CAIRO;

procedure cairo_font_extents(cr: Pcairo_t; extents: Pcairo_font_extents_t); cdecl; external LIB_CAIRO;

(* Generic identifier for a font style *)

function cairo_font_face_reference(font_face: Pcairo_font_face_t): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

procedure cairo_font_face_destroy(font_face: Pcairo_font_face_t); cdecl; external LIB_CAIRO;

function cairo_font_face_get_reference_count(font_face: Pcairo_font_face_t): cuint; cdecl; external LIB_CAIRO;

function cairo_font_face_status(font_face: Pcairo_font_face_t): cairo_status_t; cdecl; external LIB_CAIRO;

type
(**
 * cairo_font_type_t:
 * @CAIRO_FONT_TYPE_TOY: The font was created using cairo's toy font api (Since: 1.2)
 * @CAIRO_FONT_TYPE_FT: The font is of type FreeType (Since: 1.2)
 * @CAIRO_FONT_TYPE_WIN32: The font is of type Win32 (Since: 1.2)
 * @CAIRO_FONT_TYPE_QUARTZ: The font is of type Quartz (Since: 1.6, in 1.2 and
 * 1.4 it was named CAIRO_FONT_TYPE_ATSUI)
 * @CAIRO_FONT_TYPE_USER: The font was create using cairo's user font api (Since: 1.8)
 *
 * #cairo_font_type_t is used to describe the type of a given font
 * face or scaled font. The font types are also known as "font
 * backends" within cairo.
 *
 * The type of a font face is determined by the function used to
 * create it, which will generally be of the form
 * <function>cairo_<emphasis>type</emphasis>_font_face_create(<!-- -->)</function>.
 * The font face type can be queried with cairo_font_face_get_type()
 *
 * The various #cairo_font_face_t functions can be used with a font face
 * of any type.
 *
 * The type of a scaled font is determined by the type of the font
 * face passed to cairo_scaled_font_create(). The scaled font type can
 * be queried with cairo_scaled_font_get_type()
 *
 * The various #cairo_scaled_font_t functions can be used with scaled
 * fonts of any type, but some font backends also provide
 * type-specific functions that must only be called with a scaled font
 * of the appropriate type. These functions have names that begin with
 * <function>cairo_<emphasis>type</emphasis>_scaled_font(<!-- -->)</function>
 * such as cairo_ft_scaled_font_lock_face().
 *
 * The behavior of calling a type-specific function with a scaled font
 * of the wrong type is undefined.
 *
 * New entries may be added in future versions.
 *
 * Since: 1.2
 **)
  cairo_font_type_t = (
    CAIRO_FONT_TYPE_TOY,
    CAIRO_FONT_TYPE_FT,
    CAIRO_FONT_TYPE_WIN32,
    CAIRO_FONT_TYPE_QUARTZ,
    CAIRO_FONT_TYPE_USER
  );

function cairo_font_face_get_type(font_face: Pcairo_font_face_t): cairo_font_type_t; cdecl; external LIB_CAIRO;

function cairo_font_face_get_user_data(font_face: Pcairo_font_face_t; const key: Pcairo_user_data_key_t): pointer; cdecl; external LIB_CAIRO;

function cairo_font_face_set_user_data(font_face: Pcairo_font_face_t; const key: Pcairo_user_data_key_t; user_data: pointer; destroy_func: cairo_destroy_func_t): cairo_status_t; cdecl; external LIB_CAIRO;

(* Portable interface to general font features. *)

function cairo_scaled_font_create(font_face: Pcairo_font_face_t; const font_matrix: Pcairo_matrix_t; const ctm: Pcairo_matrix_t; const options: Pcairo_font_options_t): Pcairo_scaled_font_t; cdecl; external LIB_CAIRO;

function cairo_scaled_font_reference(scaled_font: Pcairo_scaled_font_t): Pcairo_scaled_font_t; cdecl; external LIB_CAIRO;

procedure cairo_scaled_font_destroy(scaled_font: Pcairo_scaled_font_t); cdecl; external LIB_CAIRO;

function cairo_scaled_font_get_reference_count(scaled_font: Pcairo_scaled_font_t): cuint; cdecl; external LIB_CAIRO;

function cairo_scaled_font_status(scaled_font: Pcairo_scaled_font_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_scaled_font_get_type(scaled_font: Pcairo_scaled_font_t): cairo_font_type_t; cdecl; external LIB_CAIRO;

function cairo_scaled_font_get_user_data(scaled_font: Pcairo_scaled_font_t; const key: Pcairo_user_data_key_t): pointer; cdecl; external LIB_CAIRO;

function cairo_scaled_font_set_user_data(scaled_font: Pcairo_scaled_font_t; const key: Pcairo_user_data_key_t; user_data: pointer; destroy_func: cairo_destroy_func_t): cairo_status_t; cdecl; external LIB_CAIRO;

procedure cairo_scaled_font_extents(scaled_font: Pcairo_scaled_font_t; extents: Pcairo_font_extents_t); cdecl; external LIB_CAIRO;

procedure cairo_scaled_font_text_extents(scaled_font: Pcairo_scaled_font_t; const utf8: pchar; extents: Pcairo_text_extents_t); cdecl; external LIB_CAIRO;

procedure cairo_scaled_font_glyph_extents(scaled_font: Pcairo_scaled_font_t; const glyphs: Pcairo_glyph_t; num_glyphs: cint; extents: Pcairo_text_extents_t); cdecl; external LIB_CAIRO;

function cairo_scaled_font_text_to_glyphs(scaled_font: Pcairo_scaled_font_t; x: cdouble; y: cdouble; const utf8: pchar; utf8_len: cint; Pglyphs: Pcairo_glyph_t; num_glyphs: pcint; clusters: PPcairo_text_cluster_t; num_clusters: pcint; cluster_flags: Pcairo_text_cluster_flags_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_scaled_font_get_font_face(scaled_font: Pcairo_scaled_font_t): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

procedure cairo_scaled_font_get_font_matrix(scaled_font: Pcairo_scaled_font_t; font_matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_scaled_font_get_ctm(scaled_font: Pcairo_scaled_font_t; ctm: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_scaled_font_get_scale_matrix(scaled_font: Pcairo_scaled_font_t; scale_matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_scaled_font_get_font_options(scaled_font: Pcairo_scaled_font_t; options: Pcairo_font_options_t); cdecl; external LIB_CAIRO;

(* Toy fonts *)

function cairo_toy_font_face_create(const family: pchar; slant: cairo_font_slant_t; weight: cairo_font_weight_t): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

function cairo_toy_font_face_get_family(font_face: Pcairo_font_face_t): pchar ; cdecl; external LIB_CAIRO;

function cairo_toy_font_face_get_slant(font_face: Pcairo_font_face_t): cairo_font_slant_t; cdecl; external LIB_CAIRO;

function cairo_toy_font_face_get_weight(font_face: Pcairo_font_face_t): cairo_font_weight_t; cdecl; external LIB_CAIRO;

(* User fonts *)

function cairo_user_font_face_create(): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

(* User-font method signatures *)

type
(**
 * cairo_user_scaled_font_init_func_t:
 * @scaled_font: the scaled-font being created
 * @cr: a cairo context, in font space
 * @extents: font extents to fill in, in font space
 *
 * #cairo_user_scaled_font_init_func_t is the type of function which is
 * called when a scaled-font needs to be created for a user font-face.
 *
 * The cairo context @cr is not used by the caller, but is prepared in font
 * space, similar to what the cairo contexts passed to the render_glyph
 * method will look like.  The callback can use this context for extents
 * computation for example.  After the callback is called, @cr is checked
 * for any error status.
 *
 * The @extents argument is where the user font sets the font extents for
 * @scaled_font.  It is in font space, which means that for most cases its
 * ascent and descent members should add to 1.0.  @extents is preset to
 * hold a value of 1.0 for ascent, height, and max_x_advance, and 0.0 for
 * descent and max_y_advance members.
 *
 * The callback is optional.  If not set, default font extents as described
 * in the previous paragraph will be used.
 *
 * Note that @scaled_font is not fully initialized at this
 * point and trying to use it for text operations in the callback will result
 * in deadlock.
 *
 * Returns: %CAIRO_STATUS_SUCCESS upon success, or an error status on error.
 *
 * Since: 1.8
 **)
  cairo_user_scaled_font_init_func_t = function (scaled_font: Pcairo_scaled_font_t; cr: Pcairo_t; extents: Pcairo_font_extents_t): cairo_status_t; cdecl;

(**
 * cairo_user_scaled_font_render_glyph_func_t:
 * @scaled_font: user scaled-font
 * @glyph: glyph code to render
 * @cr: cairo context to draw to, in font space
 * @extents: glyph extents to fill in, in font space
 *
 * #cairo_user_scaled_font_render_glyph_func_t is the type of function which
 * is called when a user scaled-font needs to render a glyph.
 *
 * The callback is mandatory, and expected to draw the glyph with code @glyph to
 * the cairo context @cr.  @cr is prepared such that the glyph drawing is done in
 * font space.  That is, the matrix set on @cr is the scale matrix of @scaled_font,
 * The @extents argument is where the user font sets the font extents for
 * @scaled_font.  However, if user prefers to draw in user space, they can
 * achieve that by changing the matrix on @cr.  All cairo rendering operations
 * to @cr are permitted, however, the result is undefined if any source other
 * than the default source on @cr is used.  That means, glyph bitmaps should
 * be rendered using cairo_mask() instead of cairo_paint().
 *
 * Other non-default settings on @cr include a font size of 1.0 (given that
 * it is set up to be in font space), and font options corresponding to
 * @scaled_font.
 *
 * The @extents argument is preset to have <literal>x_bearing</literal>,
 * <literal>width</literal>, and <literal>y_advance</literal> of zero,
 * <literal>y_bearing</literal> set to <literal>-font_extents.ascent</literal>,
 * <literal>height</literal> to <literal>font_extents.ascent+font_extents.descent</literal>,
 * and <literal>x_advance</literal> to <literal>font_extents.max_x_advance</literal>.
 * The only field user needs to set in majority of cases is
 * <literal>x_advance</literal>.
 * If the <literal>width</literal> field is zero upon the callback returning
 * (which is its preset value), the glyph extents are automatically computed
 * based on the drawings done to @cr.  This is in most cases exactly what the
 * desired behavior is.  However, if for any reason the callback sets the
 * extents, it must be ink extents, and include the extents of all drawing
 * done to @cr in the callback.
 *
 * Returns: %CAIRO_STATUS_SUCCESS upon success, or
 * %CAIRO_STATUS_USER_FONT_ERROR or any other error status on error.
 *
 * Since: 1.8
 **)
  cairo_user_scaled_font_render_glyph_func_t = function (scaled_font: Pcairo_scaled_font_t; glyph: cuint; cr: Pcairo_t; extents: Pcairo_text_extents_t): cairo_status_t; cdecl;

(**
 * cairo_user_scaled_font_text_to_glyphs_func_t:
 * @scaled_font: the scaled-font being created
 * @utf8: a string of text encoded in UTF-8
 * @utf8_len: length of @utf8 in bytes
 * @glyphs: pointer to array of glyphs to fill, in font space
 * @num_glyphs: pointer to number of glyphs
 * @clusters: pointer to array of cluster mapping information to fill, or %NULL
 * @num_clusters: pointer to number of clusters
 * @cluster_flags: pointer to location to store cluster flags corresponding to the
 *                 output @clusters
 *
 * #cairo_user_scaled_font_text_to_glyphs_func_t is the type of function which
 * is called to convert input text to an array of glyphs.  This is used by the
 * cairo_show_text() operation.
 *
 * Using this callback the user-font has full control on glyphs and their
 * positions.  That means, it allows for features like ligatures and kerning,
 * as well as complex <firstterm>shaping</firstterm> required for scripts like
 * Arabic and Indic.
 *
 * The @num_glyphs argument is preset to the number of glyph entries available
 * in the @glyphs buffer. If the @glyphs buffer is %NULL, the value of
 * @num_glyphs will be zero.  If the provided glyph array is too short for
 * the conversion (or for convenience), a new glyph array may be allocated
 * using cairo_glyph_allocate() and placed in @glyphs.  Upon return,
 * @num_glyphs should contain the number of generated glyphs.  If the value
 * @glyphs points at has changed after the call, the caller will free the
 * allocated glyph array using cairo_glyph_free().  The caller will also free
 * the original value of @glyphs, so the callback shouldn't do so.
 * The callback should populate the glyph indices and positions (in font space)
 * assuming that the text is to be shown at the origin.
 *
 * If @clusters is not %NULL, @num_clusters and @cluster_flags are also
 * non-%NULL, and cluster mapping should be computed. The semantics of how
 * cluster array allocation works is similar to the glyph array.  That is,
 * if @clusters initially points to a non-%NULL value, that array may be used
 * as a cluster buffer, and @num_clusters points to the number of cluster
 * entries available there.  If the provided cluster array is too short for
 * the conversion (or for convenience), a new cluster array may be allocated
 * using cairo_text_cluster_allocate() and placed in @clusters.  In this case,
 * the original value of @clusters will still be freed by the caller.  Upon
 * return, @num_clusters should contain the number of generated clusters.
 * If the value @clusters points at has changed after the call, the caller
 * will free the allocated cluster array using cairo_text_cluster_free().
 *
 * The callback is optional.  If @num_glyphs is negative upon
 * the callback returning or if the return value
 * is %CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED, the unicode_to_glyph callback
 * is tried.  See #cairo_user_scaled_font_unicode_to_glyph_func_t.
 *
 * Note: While cairo does not impose any limitation on glyph indices,
 * some applications may assume that a glyph index fits in a 16-bit
 * unsigned integer.  As such, it is advised that user-fonts keep their
 * glyphs in the 0 to 65535 range.  Furthermore, some applications may
 * assume that glyph 0 is a special glyph-not-found glyph.  User-fonts
 * are advised to use glyph 0 for such purposes and do not use that
 * glyph value for other purposes.
 *
 * Returns: %CAIRO_STATUS_SUCCESS upon success,
 * %CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED if fallback options should be tried,
 * or %CAIRO_STATUS_USER_FONT_ERROR or any other error status on error.
 *
 * Since: 1.8
 **)
  cairo_user_scaled_font_text_to_glyphs_func_t = function (scaled_font: Pcairo_scaled_font_t; const utf8: pchar; utf8_len: cint; glyphs: PPcairo_glyph_t; pnum_glyphs: cint; clusters: PPcairo_text_cluster_t; pnum_clusters: cint; cluster_flags: Pcairo_text_cluster_flags_t): cairo_status_t; cdecl;

(**
 * cairo_user_scaled_font_unicode_to_glyph_func_t:
 * @scaled_font: the scaled-font being created
 * @unicode: input unicode character code-point
 * @glyph_index: output glyph index
 *
 * #cairo_user_scaled_font_unicode_to_glyph_func_t is the type of function which
 * is called to convert an input Unicode character to a single glyph.
 * This is used by the cairo_show_text() operation.
 *
 * This callback is used to provide the same functionality as the
 * text_to_glyphs callback does (see #cairo_user_scaled_font_text_to_glyphs_func_t)
 * but has much less control on the output,
 * in exchange for increased ease of use.  The inherent assumption to using
 * this callback is that each character maps to one glyph, and that the
 * mapping is context independent.  It also assumes that glyphs are positioned
 * according to their advance width.  These mean no ligatures, kerning, or
 * complex scripts can be implemented using this callback.
 *
 * The callback is optional, and only used if text_to_glyphs callback is not
 * set or fails to return glyphs.  If this callback is not set or if it returns
 * %CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED, an identity mapping from Unicode
 * code-points to glyph indices is assumed.
 *
 * Note: While cairo does not impose any limitation on glyph indices,
 * some applications may assume that a glyph index fits in a 16-bit
 * unsigned integer.  As such, it is advised that user-fonts keep their
 * glyphs in the 0 to 65535 range.  Furthermore, some applications may
 * assume that glyph 0 is a special glyph-not-found glyph.  User-fonts
 * are advised to use glyph 0 for such purposes and do not use that
 * glyph value for other purposes.
 *
 * Returns: %CAIRO_STATUS_SUCCESS upon success,
 * %CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED if fallback options should be tried,
 * or %CAIRO_STATUS_USER_FONT_ERROR or any other error status on error.
 *
 * Since: 1.8
 **)
  cairo_user_scaled_font_unicode_to_glyph_func_t = function (scaled_font: Pcairo_scaled_font_t; unicode: cuint; glyph_index: pcuint): cairo_status_t; cdecl;

(* User-font method setters *)

procedure cairo_user_font_face_set_init_func(font_face: Pcairo_font_face_t; init_func: cairo_user_scaled_font_init_func_t); cdecl; external LIB_CAIRO;

procedure cairo_user_font_face_set_render_glyph_func(font_face: Pcairo_font_face_t; render_glyph_func: cairo_user_scaled_font_render_glyph_func_t); cdecl; external LIB_CAIRO;

procedure cairo_user_font_face_set_text_to_glyphs_func(font_face: Pcairo_font_face_t; text_to_glyphs_func: cairo_user_scaled_font_text_to_glyphs_func_t); cdecl; external LIB_CAIRO;

procedure cairo_user_font_face_set_unicode_to_glyph_func(font_face: Pcairo_font_face_t; unicode_to_glyph_func: cairo_user_scaled_font_unicode_to_glyph_func_t); cdecl; external LIB_CAIRO;

(* User-font method getters *)

function cairo_user_font_face_get_init_func(font_face: Pcairo_font_face_t): cairo_user_scaled_font_init_func_t; cdecl; external LIB_CAIRO;

function cairo_user_font_face_get_render_glyph_func(font_face: Pcairo_font_face_t): cairo_user_scaled_font_render_glyph_func_t; cdecl; external LIB_CAIRO;

function cairo_user_font_face_get_text_to_glyphs_func(font_face: Pcairo_font_face_t): cairo_user_scaled_font_text_to_glyphs_func_t; cdecl; external LIB_CAIRO;

function cairo_user_font_face_get_unicode_to_glyph_func(font_face: Pcairo_font_face_t): cairo_user_scaled_font_unicode_to_glyph_func_t; cdecl; external LIB_CAIRO;

(* Query functions *)

function cairo_get_operator(cr: Pcairo_t): cairo_operator_t; cdecl; external LIB_CAIRO;

function cairo_get_source(cr: Pcairo_t): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

function cairo_get_tolerance(cr: Pcairo_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_get_antialias(cr: Pcairo_t): cairo_antialias_t; cdecl; external LIB_CAIRO;

function cairo_has_current_point(cr: Pcairo_t): cairo_bool_t; cdecl; external LIB_CAIRO;

procedure cairo_get_current_point(cr: Pcairo_t; x: pcdouble; y: pcdouble); cdecl; external LIB_CAIRO;

function cairo_get_fill_rule(cr: Pcairo_t): cairo_fill_rule_t; cdecl; external LIB_CAIRO;

function cairo_get_line_width(cr: Pcairo_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_get_line_cap(cr: Pcairo_t): cairo_line_cap_t; cdecl; external LIB_CAIRO;

function cairo_get_line_join(cr: Pcairo_t): cairo_line_join_t; cdecl; external LIB_CAIRO;

function cairo_get_miter_limit(cr: Pcairo_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_get_dash_count(cr: Pcairo_t): cint; cdecl; external LIB_CAIRO;

procedure cairo_get_dash(cr: Pcairo_t; dashes: pcdouble; offset: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_get_matrix(cr: Pcairo_t; matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

function cairo_get_target(cr: Pcairo_t): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_get_group_target(cr: Pcairo_t): Pcairo_surface_t; cdecl; external LIB_CAIRO;

type
(**
 * cairo_path_data_type_t:
 * @CAIRO_PATH_MOVE_TO: A move-to operation, since 1.0
 * @CAIRO_PATH_LINE_TO: A line-to operation, since 1.0
 * @CAIRO_PATH_CURVE_TO: A curve-to operation, since 1.0
 * @CAIRO_PATH_CLOSE_PATH: A close-path operation, since 1.0
 *
 * #cairo_path_data_t is used to describe the type of one portion
 * of a path when represented as a #cairo_path_t.
 * See #cairo_path_data_t for details.
 *
 * Since: 1.0
 **)
  cairo_path_data_type_t = (
    CAIRO_PATH_MOVE_TO,
    CAIRO_PATH_LINE_TO,
    CAIRO_PATH_CURVE_TO,
    CAIRO_PATH_CLOSE_PATH
  );

(**
 * cairo_path_data_t:
 *
 * #cairo_path_data_t is used to represent the path data inside a
 * #cairo_path_t.
 *
 * The data structure is designed to try to balance the demands of
 * efficiency and ease-of-use. A path is represented as an array of
 * #cairo_path_data_t, which is a union of headers and points.
 *
 * Each portion of the path is represented by one or more elements in
 * the array, (one header followed by 0 or more points). The length
 * value of the header is the number of array elements for the current
 * portion including the header, (ie. length == 1 + # of points), and
 * where the number of points for each element type is as follows:
 *
 * <programlisting>
 *     %CAIRO_PATH_MOVE_TO:     1 point
 *     %CAIRO_PATH_LINE_TO:     1 point
 *     %CAIRO_PATH_CURVE_TO:    3 points
 *     %CAIRO_PATH_CLOSE_PATH:  0 points
 * </programlisting>
 *
 * The semantics and ordering of the coordinate values are consistent
 * with cairo_move_to(), cairo_line_to(), cairo_curve_to(), and
 * cairo_close_path().
 *
 * Here is sample code for iterating through a #cairo_path_t:
 *
 * <informalexample><programlisting>
 *      int i;
 *      cairo_path_t *path;
 *      cairo_path_data_t *data;
 * &nbsp;
 *      path = cairo_copy_path (cr);
 * &nbsp;
 *      for (i=0; i < path->num_data; i += path->data[i].header.length) {
 *          data = &amp;path->data[i];
 *          switch (data->header.type) {
 *          case CAIRO_PATH_MOVE_TO:
 *              do_move_to_things (data[1].point.x, data[1].point.y);
 *              break;
 *          case CAIRO_PATH_LINE_TO:
 *              do_line_to_things (data[1].point.x, data[1].point.y);
 *              break;
 *          case CAIRO_PATH_CURVE_TO:
 *              do_curve_to_things (data[1].point.x, data[1].point.y,
 *                                  data[2].point.x, data[2].point.y,
 *                                  data[3].point.x, data[3].point.y);
 *              break;
 *          case CAIRO_PATH_CLOSE_PATH:
 *              do_close_path_things ();
 *              break;
 *          }
 *      }
 *      cairo_path_destroy (path);
 * </programlisting></informalexample>
 *
 * As of cairo 1.4, cairo does not mind if there are more elements in
 * a portion of the path than needed.  Such elements can be used by
 * users of the cairo API to hold extra values in the path data
 * structure.  For this reason, it is recommended that applications
 * always use <literal>data->header.length</literal> to
 * iterate over the path data, instead of hardcoding the number of
 * elements for each element type.
 *
 * Since: 1.0
 **)
  Pcairo_path_data_t = ^cairo_path_data_t;
  cairo_path_data_t = record
    case cint of
      0: (
	      header: record
          type_: cairo_path_data_type_t;
          length: cint;
        end
      );
      1: (
	      point: record
          x: cdouble;
          y: cdouble;
        end
      );
  end;

(**
 * cairo_path_t:
 * @status: the current error status
 * @data: the elements in the path
 * @num_data: the number of elements in the data array
 *
 * A data structure for holding a path. This data structure serves as
 * the return value for cairo_copy_path() and
 * cairo_copy_path_flat() as well the input value for
 * cairo_append_path().
 *
 * See #cairo_path_data_t for hints on how to iterate over the
 * actual data within the path.
 *
 * The num_data member gives the number of elements in the data
 * array. This number is larger than the number of independent path
 * portions (defined in #cairo_path_data_type_t), since the data
 * includes both headers and coordinates for each portion.
 *
 * Since: 1.0
 **)
  Pcairo_path_t = ^cairo_path_t;
  cairo_path_t = record
    status: cairo_status_t;
    data: Pcairo_path_data_t;
    num_data: cint;
  end;

function cairo_copy_path(cr: Pcairo_t): Pcairo_path_t; cdecl; external LIB_CAIRO;

function cairo_copy_path_flat(cr: Pcairo_t): Pcairo_path_t; cdecl; external LIB_CAIRO;

procedure cairo_append_path(cr: Pcairo_t; const path: Pcairo_path_t); cdecl; external LIB_CAIRO;

procedure cairo_path_destroy(path: Pcairo_path_t); cdecl; external LIB_CAIRO;

(* Error status queries *)

function cairo_status(cr: Pcairo_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_status_to_string(status: cairo_status_t): pchar ; cdecl; external LIB_CAIRO;

(* Backend device manipulation *)

function cairo_device_reference(device: Pcairo_device_t): Pcairo_device_t; cdecl; external LIB_CAIRO;

type
(**
 * cairo_device_type_t:
 * @CAIRO_DEVICE_TYPE_DRM: The device is of type Direct Render Manager, since 1.10
 * @CAIRO_DEVICE_TYPE_GL: The device is of type OpenGL, since 1.10
 * @CAIRO_DEVICE_TYPE_SCRIPT: The device is of type script, since 1.10
 * @CAIRO_DEVICE_TYPE_XCB: The device is of type xcb, since 1.10
 * @CAIRO_DEVICE_TYPE_XLIB: The device is of type xlib, since 1.10
 * @CAIRO_DEVICE_TYPE_XML: The device is of type XML, since 1.10
 * @CAIRO_DEVICE_TYPE_COGL: The device is of type cogl, since 1.12
 * @CAIRO_DEVICE_TYPE_WIN32: The device is of type win32, since 1.12
 * @CAIRO_DEVICE_TYPE_INVALID: The device is invalid, since 1.10
 *
 * #cairo_device_type_t is used to describe the type of a given
 * device. The devices types are also known as "backends" within cairo.
 *
 * The device type can be queried with cairo_device_get_type()
 *
 * The various #cairo_device_t functions can be used with devices of
 * any type, but some backends also provide type-specific functions
 * that must only be called with a device of the appropriate
 * type. These functions have names that begin with
 * <literal>cairo_<emphasis>type</emphasis>_device</literal> such as
 * cairo_xcb_device_debug_cap_xrender_version().
 *
 * The behavior of calling a type-specific function with a device of
 * the wrong type is undefined.
 *
 * New entries may be added in future versions.
 *
 * Since: 1.10
 **)
  cairo_device_type_t = (
    CAIRO_DEVICE_TYPE_INVALID = -1,

    CAIRO_DEVICE_TYPE_DRM,
    CAIRO_DEVICE_TYPE_GL,
    CAIRO_DEVICE_TYPE_SCRIPT,
    CAIRO_DEVICE_TYPE_XCB,
    CAIRO_DEVICE_TYPE_XLIB,
    CAIRO_DEVICE_TYPE_XML,
    CAIRO_DEVICE_TYPE_COGL,
    CAIRO_DEVICE_TYPE_WIN32
  );

function cairo_device_get_type(device: Pcairo_device_t): cairo_device_type_t; cdecl; external LIB_CAIRO;

function cairo_device_status(device: Pcairo_device_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_device_acquire(device: Pcairo_device_t): cairo_status_t; cdecl; external LIB_CAIRO;

procedure cairo_device_release(device: Pcairo_device_t); cdecl; external LIB_CAIRO;

procedure cairo_device_flush(device: Pcairo_device_t); cdecl; external LIB_CAIRO;

procedure cairo_device_finish(device: Pcairo_device_t); cdecl; external LIB_CAIRO;

procedure cairo_device_destroy(device: Pcairo_device_t); cdecl; external LIB_CAIRO;

function cairo_device_get_reference_count(device: Pcairo_device_t): cuint; cdecl; external LIB_CAIRO;

function cairo_device_get_user_data(device: Pcairo_device_t; const key: Pcairo_user_data_key_t): pointer; cdecl; external LIB_CAIRO;

function cairo_device_set_user_data(device: Pcairo_device_t; const key: Pcairo_user_data_key_t; user_data: pointer; destroy_func: cairo_destroy_func_t): cairo_status_t; cdecl; external LIB_CAIRO;

(* Surface manipulation *)

function cairo_surface_create_similar(other: Pcairo_surface_t; content: cairo_content_t; width: cint; height: cint): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_surface_create_similar_image(other: Pcairo_surface_t; format: cairo_format_t; width: cint; height: cint): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_surface_map_to_image(surface: Pcairo_surface_t; const extents: Pcairo_rectangle_int_t): Pcairo_surface_t; cdecl; external LIB_CAIRO;

procedure cairo_surface_unmap_image(surface: Pcairo_surface_t; image: Pcairo_surface_t); cdecl; external LIB_CAIRO;

function cairo_surface_create_for_rectangle(target: Pcairo_surface_t; x: cdouble; y: cdouble; width: cdouble; height: cdouble): Pcairo_surface_t; cdecl; external LIB_CAIRO;

type
(**
 * cairo_surface_observer_mode_t:
 * @CAIRO_SURFACE_OBSERVER_NORMAL: no recording is done
 * @CAIRO_SURFACE_OBSERVER_RECORD_OPERATIONS: operations are recorded
 *
 * Whether operations should be recorded.
 *
 * Since: 1.12
 **)
  cairo_surface_observer_mode_t = (
    CAIRO_SURFACE_OBSERVER_NORMAL = 0,
    CAIRO_SURFACE_OBSERVER_RECORD_OPERATIONS = $1
  );

function cairo_surface_create_observer(target: Pcairo_surface_t; mode: cairo_surface_observer_mode_t): Pcairo_surface_t; cdecl; external LIB_CAIRO;

type
  cairo_surface_observer_callback_t = procedure (observer: Pcairo_surface_t; target: Pcairo_surface_t; data: pointer); cdecl;

function cairo_surface_observer_add_paint_callback(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; data: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_observer_add_mask_callback(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; data: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_observer_add_fill_callback(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; data: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_observer_add_stroke_callback(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; data: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_observer_add_glyphs_callback(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; data: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_observer_add_flush_callback(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; data: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_observer_add_finish_callback(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; data: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_observer_print(surface: Pcairo_surface_t; write_func: cairo_write_func_t; closure: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_observer_elapsed(surface: Pcairo_surface_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_device_observer_print(device: Pcairo_device_t; write_func: cairo_write_func_t; closure: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_device_observer_elapsed(device: Pcairo_device_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_device_observer_paint_elapsed(device: Pcairo_device_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_device_observer_mask_elapsed(device: Pcairo_device_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_device_observer_fill_elapsed(device: Pcairo_device_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_device_observer_stroke_elapsed(device: Pcairo_device_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_device_observer_glyphs_elapsed(device: Pcairo_device_t): cdouble; cdecl; external LIB_CAIRO;

function cairo_surface_reference(surface: Pcairo_surface_t): Pcairo_surface_t; cdecl; external LIB_CAIRO;

procedure cairo_surface_finish(surface: Pcairo_surface_t); cdecl; external LIB_CAIRO;

procedure cairo_surface_destroy(surface: Pcairo_surface_t); cdecl; external LIB_CAIRO;

function cairo_surface_get_device(surface: Pcairo_surface_t): Pcairo_device_t; cdecl; external LIB_CAIRO;

function cairo_surface_get_reference_count(surface: Pcairo_surface_t): cuint; cdecl; external LIB_CAIRO;

function cairo_surface_status(surface: Pcairo_surface_t): cairo_status_t; cdecl; external LIB_CAIRO;

type
(**
 * cairo_surface_type_t:
 * @CAIRO_SURFACE_TYPE_IMAGE: The surface is of type image, since 1.2
 * @CAIRO_SURFACE_TYPE_PDF: The surface is of type pdf, since 1.2
 * @CAIRO_SURFACE_TYPE_PS: The surface is of type ps, since 1.2
 * @CAIRO_SURFACE_TYPE_XLIB: The surface is of type xlib, since 1.2
 * @CAIRO_SURFACE_TYPE_XCB: The surface is of type xcb, since 1.2
 * @CAIRO_SURFACE_TYPE_GLITZ: The surface is of type glitz, since 1.2
 * @CAIRO_SURFACE_TYPE_QUARTZ: The surface is of type quartz, since 1.2
 * @CAIRO_SURFACE_TYPE_WIN32: The surface is of type win32, since 1.2
 * @CAIRO_SURFACE_TYPE_BEOS: The surface is of type beos, since 1.2
 * @CAIRO_SURFACE_TYPE_DIRECTFB: The surface is of type directfb, since 1.2
 * @CAIRO_SURFACE_TYPE_SVG: The surface is of type svg, since 1.2
 * @CAIRO_SURFACE_TYPE_OS2: The surface is of type os2, since 1.4
 * @CAIRO_SURFACE_TYPE_WIN32_PRINTING: The surface is a win32 printing surface, since 1.6
 * @CAIRO_SURFACE_TYPE_QUARTZ_IMAGE: The surface is of type quartz_image, since 1.6
 * @CAIRO_SURFACE_TYPE_SCRIPT: The surface is of type script, since 1.10
 * @CAIRO_SURFACE_TYPE_QT: The surface is of type Qt, since 1.10
 * @CAIRO_SURFACE_TYPE_RECORDING: The surface is of type recording, since 1.10
 * @CAIRO_SURFACE_TYPE_VG: The surface is a OpenVG surface, since 1.10
 * @CAIRO_SURFACE_TYPE_GL: The surface is of type OpenGL, since 1.10
 * @CAIRO_SURFACE_TYPE_DRM: The surface is of type Direct Render Manager, since 1.10
 * @CAIRO_SURFACE_TYPE_TEE: The surface is of type 'tee' (a multiplexing surface), since 1.10
 * @CAIRO_SURFACE_TYPE_XML: The surface is of type XML (for debugging), since 1.10
 * @CAIRO_SURFACE_TYPE_SKIA: The surface is of type Skia, since 1.10
 * @CAIRO_SURFACE_TYPE_SUBSURFACE: The surface is a subsurface created with
 *   cairo_surface_create_for_rectangle(), since 1.10
 * @CAIRO_SURFACE_TYPE_COGL: This surface is of type Cogl, since 1.12
 *
 * #cairo_surface_type_t is used to describe the type of a given
 * surface. The surface types are also known as "backends" or "surface
 * backends" within cairo.
 *
 * The type of a surface is determined by the function used to create
 * it, which will generally be of the form
 * <function>cairo_<emphasis>type</emphasis>_surface_create(<!-- -->)</function>,
 * (though see cairo_surface_create_similar() as well).
 *
 * The surface type can be queried with cairo_surface_get_type()
 *
 * The various #cairo_surface_t functions can be used with surfaces of
 * any type, but some backends also provide type-specific functions
 * that must only be called with a surface of the appropriate
 * type. These functions have names that begin with
 * <literal>cairo_<emphasis>type</emphasis>_surface</literal> such as cairo_image_surface_get_width().
 *
 * The behavior of calling a type-specific function with a surface of
 * the wrong type is undefined.
 *
 * New entries may be added in future versions.
 *
 * Since: 1.2
 **)
  cairo_surface_type_t = (
    CAIRO_SURFACE_TYPE_IMAGE,
    CAIRO_SURFACE_TYPE_PDF,
    CAIRO_SURFACE_TYPE_PS,
    CAIRO_SURFACE_TYPE_XLIB,
    CAIRO_SURFACE_TYPE_XCB,
    CAIRO_SURFACE_TYPE_GLITZ,
    CAIRO_SURFACE_TYPE_QUARTZ,
    CAIRO_SURFACE_TYPE_WIN32,
    CAIRO_SURFACE_TYPE_BEOS,
    CAIRO_SURFACE_TYPE_DIRECTFB,
    CAIRO_SURFACE_TYPE_SVG,
    CAIRO_SURFACE_TYPE_OS2,
    CAIRO_SURFACE_TYPE_WIN32_PRINTING,
    CAIRO_SURFACE_TYPE_QUARTZ_IMAGE,
    CAIRO_SURFACE_TYPE_SCRIPT,
    CAIRO_SURFACE_TYPE_QT,
    CAIRO_SURFACE_TYPE_RECORDING,
    CAIRO_SURFACE_TYPE_VG,
    CAIRO_SURFACE_TYPE_GL,
    CAIRO_SURFACE_TYPE_DRM,
    CAIRO_SURFACE_TYPE_TEE,
    CAIRO_SURFACE_TYPE_XML,
    CAIRO_SURFACE_TYPE_SKIA,
    CAIRO_SURFACE_TYPE_SUBSURFACE,
    CAIRO_SURFACE_TYPE_COGL
  );

function cairo_surface_get_type(surface: Pcairo_surface_t): cairo_surface_type_t; cdecl; external LIB_CAIRO;

function cairo_surface_get_content(surface: Pcairo_surface_t): cairo_content_t; cdecl; external LIB_CAIRO;

{$ifdef CAIRO_HAS_PNG_FUNCTIONS}

function cairo_surface_write_to_png(surface: Pcairo_surface_t; const filename: pchar): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_write_to_png_stream(surface: Pcairo_surface_t; write_func: cairo_write_func_t; closure: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

{$endif}

function cairo_surface_get_user_data(surface: Pcairo_surface_t; const key: Pcairo_user_data_key_t): pointer ; cdecl; external LIB_CAIRO;

function cairo_surface_set_user_data(surface: Pcairo_surface_t; const key: Pcairo_user_data_key_t; user_data: pointer; destroy_func: cairo_destroy_func_t): cairo_status_t; cdecl; external LIB_CAIRO;

const
  CAIRO_MIME_TYPE_JPEG = 'image/jpeg';
  CAIRO_MIME_TYPE_PNG = 'image/png';
  CAIRO_MIME_TYPE_JP2 = 'image/jp2';
  CAIRO_MIME_TYPE_URI = 'text/x-uri';
  CAIRO_MIME_TYPE_UNIQUE_ID = 'application/x-cairo.uuid';
  CAIRO_MIME_TYPE_JBIG2 = 'application/x-cairo.jbig2';
  CAIRO_MIME_TYPE_JBIG2_GLOBAL = 'application/x-cairo.jbig2-global';
  CAIRO_MIME_TYPE_JBIG2_GLOBAL_ID = 'application/x-cairo.jbig2-global-id';

type
  ppcuchar = ^pcuchar;

procedure cairo_surface_get_mime_data(surface: Pcairo_surface_t; const mime_type: pchar; const data: ppcuchar; length: pcuint); cdecl; external LIB_CAIRO;

function cairo_surface_set_mime_data(surface: Pcairo_surface_t; const mime_type: pchar; const data: pcuchar; length: cuint; destroy_func: cairo_destroy_func_t; closure: pointer): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_surface_supports_mime_type(surface: Pcairo_surface_t; const mime_type: pchar): cairo_bool_t; cdecl; external LIB_CAIRO;

procedure cairo_surface_get_font_options(surface: Pcairo_surface_t; options: Pcairo_font_options_t); cdecl; external LIB_CAIRO;

procedure cairo_surface_flush(surface: Pcairo_surface_t); cdecl; external LIB_CAIRO;

procedure cairo_surface_mark_dirty(surface: Pcairo_surface_t); cdecl; external LIB_CAIRO;

procedure cairo_surface_mark_dirty_rectangle(surface: Pcairo_surface_t; x: cint; y: cint; width: cint; height: cint); cdecl; external LIB_CAIRO;

procedure cairo_surface_set_device_scale(surface: Pcairo_surface_t; x_scale: cdouble; y_scale: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_surface_get_device_scale(surface: Pcairo_surface_t; x_scale: pcdouble; y_scale: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_surface_set_device_offset(surface: Pcairo_surface_t; x_offset: cdouble; y_offset: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_surface_get_device_offset(surface: Pcairo_surface_t; x_offset: pcdouble; y_offset: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_surface_set_fallback_resolution(surface: Pcairo_surface_t; x_pixels_per_inch: cdouble; y_pixels_per_inch: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_surface_get_fallback_resolution(surface: Pcairo_surface_t; x_pixels_per_inch: pcdouble; y_pixels_per_inch: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_surface_copy_page(surface: Pcairo_surface_t); cdecl; external LIB_CAIRO;

procedure cairo_surface_show_page(surface: Pcairo_surface_t); cdecl; external LIB_CAIRO;

function cairo_surface_has_show_text_glyphs(surface: Pcairo_surface_t): cairo_bool_t; cdecl; external LIB_CAIRO;

(* Image-surface functions *)

function cairo_image_surface_create(format: cairo_format_t; width: cint; height: cint): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_format_stride_for_width(format: cairo_format_t; width: cint): cint; cdecl; external LIB_CAIRO;

function cairo_image_surface_create_for_data(data: pcuchar; format: cairo_format_t; width: cint; height: cint; stride: cint): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_image_surface_get_data(surface: Pcairo_surface_t): pcuchar ; cdecl; external LIB_CAIRO;

function cairo_image_surface_get_format(surface: Pcairo_surface_t): cairo_format_t; cdecl; external LIB_CAIRO;

function cairo_image_surface_get_width(surface: Pcairo_surface_t): cint; cdecl; external LIB_CAIRO;

function cairo_image_surface_get_height(surface: Pcairo_surface_t): cint; cdecl; external LIB_CAIRO;

function cairo_image_surface_get_stride(surface: Pcairo_surface_t): cint; cdecl; external LIB_CAIRO;

{$ifdef CAIRO_HAS_PNG_FUNCTIONS}

function cairo_image_surface_create_from_png(const filename: pchar): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_image_surface_create_from_png_stream(read_func: cairo_read_func_t; closure: pointer): Pcairo_surface_t; cdecl; external LIB_CAIRO;

{$endif}

(* Recording-surface functions *)

function cairo_recording_surface_create(content: cairo_content_t; const extents: Pcairo_rectangle_t): Pcairo_surface_t; cdecl; external LIB_CAIRO;

procedure cairo_recording_surface_ink_extents(surface: Pcairo_surface_t; x0: pcdouble; y0: pcdouble; width: pcdouble; height: pcdouble); cdecl; external LIB_CAIRO;

function cairo_recording_surface_get_extents(surface: Pcairo_surface_t; extents: Pcairo_rectangle_t): cairo_bool_t; cdecl; external LIB_CAIRO;

(* raster-source pattern (callback) functions *)

type
(**
 * cairo_raster_source_acquire_func_t:
 * @pattern: the pattern being rendered from
 * @callback_data: the user data supplied during creation
 * @target: the rendering target surface
 * @extents: rectangular region of interest in pixels in sample space
 *
 * #cairo_raster_source_acquire_func_t is the type of function which is
 * called when a pattern is being rendered from. It should create a surface
 * that provides the pixel data for the region of interest as defined by
 * extents, though the surface itself does not have to be limited to that
 * area. For convenience the surface should probably be of image type,
 * created with cairo_surface_create_similar_image() for the target (which
 * enables the number of copies to be reduced during transfer to the
 * device). Another option, might be to return a similar surface to the
 * target for explicit handling by the application of a set of cached sources
 * on the device. The region of sample data provided should be defined using
 * cairo_surface_set_device_offset() to specify the top-left corner of the
 * sample data (along with width and height of the surface).
 *
 * Returns: a #cairo_surface_t
 *
 * Since: 1.12
 **)
  Pcairo_raster_source_acquire_func_t = ^cairo_raster_source_acquire_func_t;
  cairo_raster_source_acquire_func_t = function (pattern: Pcairo_pattern_t; callback_data: pointer; target: Pcairo_surface_t; const extents: Pcairo_rectangle_int_t): Pcairo_surface_t; cdecl;

(**
 * cairo_raster_source_release_func_t:
 * @pattern: the pattern being rendered from
 * @callback_data: the user data supplied during creation
 * @surface: the surface created during acquire
 *
 * #cairo_raster_source_release_func_t is the type of function which is
 * called when the pixel data is no longer being access by the pattern
 * for the rendering operation. Typically this function will simply
 * destroy the surface created during acquire.
 *
 * Since: 1.12
 **)
  Pcairo_raster_source_release_func_t = ^cairo_raster_source_release_func_t;
  cairo_raster_source_release_func_t = procedure (pattern: Pcairo_pattern_t; callback_data: pointer; surface: Pcairo_surface_t); cdecl;

(**
 * cairo_raster_source_snapshot_func_t:
 * @pattern: the pattern being rendered from
 * @callback_data: the user data supplied during creation
 *
 * #cairo_raster_source_snapshot_func_t is the type of function which is
 * called when the pixel data needs to be preserved for later use
 * during printing. This pattern will be accessed again later, and it
 * is expected to provide the pixel data that was current at the time
 * of snapshotting.
 *
 * Return value: CAIRO_STATUS_SUCCESS on success, or one of the
 * #cairo_status_t error codes for failure.
 *
 * Since: 1.12
 **)
  cairo_raster_source_snapshot_func_t = function (pattern: Pcairo_pattern_t; callback_data: pointer): cairo_status_t; cdecl;

(**
 * cairo_raster_source_copy_func_t:
 * @pattern: the #cairo_pattern_t that was copied to
 * @callback_data: the user data supplied during creation
 * @other: the #cairo_pattern_t being used as the source for the copy
 *
 * #cairo_raster_source_copy_func_t is the type of function which is
 * called when the pattern gets copied as a normal part of rendering.
 *
 * Return value: CAIRO_STATUS_SUCCESS on success, or one of the
 * #cairo_status_t error codes for failure.
 *
 * Since: 1.12
 **)
  cairo_raster_source_copy_func_t = function (pattern: Pcairo_pattern_t; callback_data: pointer; const other: Pcairo_pattern_t): cairo_status_t; cdecl;

(**
 * cairo_raster_source_finish_func_t:
 * @pattern: the pattern being rendered from
 * @callback_data: the user data supplied during creation
 *
 * #cairo_raster_source_finish_func_t is the type of function which is
 * called when the pattern (or a copy thereof) is no longer required.
 *
 * Since: 1.12
 **)
  cairo_raster_source_finish_func_t = procedure (pattern: Pcairo_pattern_t; callback_data: pointer); cdecl;

function cairo_pattern_create_raster_source(user_data: pointer; content: cairo_content_t; width: cint; height: cint): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

procedure cairo_raster_source_pattern_set_callback_data(pattern: Pcairo_pattern_t; data: pointer); cdecl; external LIB_CAIRO;

function cairo_raster_source_pattern_get_callback_data(pattern: Pcairo_pattern_t): pointer; cdecl; external LIB_CAIRO;

procedure cairo_raster_source_pattern_set_acquire(pattern: Pcairo_pattern_t; acquire: cairo_raster_source_acquire_func_t; release: cairo_raster_source_release_func_t); cdecl; external LIB_CAIRO;

procedure cairo_raster_source_pattern_get_acquire(pattern: Pcairo_pattern_t; acquire: Pcairo_raster_source_acquire_func_t; release: Pcairo_raster_source_release_func_t); cdecl; external LIB_CAIRO;

procedure cairo_raster_source_pattern_set_snapshot(pattern: Pcairo_pattern_t; snapshot: cairo_raster_source_snapshot_func_t); cdecl; external LIB_CAIRO;

function cairo_raster_source_pattern_get_snapshot(pattern: Pcairo_pattern_t): cairo_raster_source_snapshot_func_t; cdecl; external LIB_CAIRO;

procedure cairo_raster_source_pattern_set_copy(pattern: Pcairo_pattern_t; copy: cairo_raster_source_copy_func_t); cdecl; external LIB_CAIRO;

function cairo_raster_source_pattern_get_copy(pattern: Pcairo_pattern_t): cairo_raster_source_copy_func_t; cdecl; external LIB_CAIRO;

procedure cairo_raster_source_pattern_set_finish(pattern: Pcairo_pattern_t; finish: cairo_raster_source_finish_func_t); cdecl; external LIB_CAIRO;

function cairo_raster_source_pattern_get_finish(pattern: Pcairo_pattern_t): cairo_raster_source_finish_func_t; cdecl; external LIB_CAIRO;

(* Pattern creation functions *)

function cairo_pattern_create_rgb(red: cdouble; green: cdouble; blue: cdouble): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

function cairo_pattern_create_rgba(red: cdouble; green: cdouble; blue: cdouble; alpha: cdouble): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

function cairo_pattern_create_for_surface(surface: Pcairo_surface_t): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

function cairo_pattern_create_linear(x0: cdouble; y0: cdouble; x1: cdouble; y1: cdouble): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

function cairo_pattern_create_radial(cx0: double; cy0: cdouble; radius0: cdouble; cx1: cdouble; cy1: cdouble; radius1: cdouble): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

function cairo_pattern_create_mesh(): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

function cairo_pattern_reference(pattern: Pcairo_pattern_t): Pcairo_pattern_t; cdecl; external LIB_CAIRO;

procedure cairo_pattern_destroy(pattern: Pcairo_pattern_t); cdecl; external LIB_CAIRO;

function cairo_pattern_get_reference_count(pattern: Pcairo_pattern_t): cuint; cdecl; external LIB_CAIRO;

function cairo_pattern_status(pattern: Pcairo_pattern_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_pattern_get_user_data(pattern: Pcairo_pattern_t; const key: Pcairo_user_data_key_t): pointer; cdecl; external LIB_CAIRO;

function cairo_pattern_set_user_data(pattern: Pcairo_pattern_t; const key: Pcairo_user_data_key_t; user_data: pointer; destroy_func: cairo_destroy_func_t): cairo_status_t; cdecl; external LIB_CAIRO;

type
(**
 * cairo_pattern_type_t:
 * @CAIRO_PATTERN_TYPE_SOLID: The pattern is a solid (uniform)
 * color. It may be opaque or translucent, since 1.2.
 * @CAIRO_PATTERN_TYPE_SURFACE: The pattern is a based on a surface (an image), since 1.2.
 * @CAIRO_PATTERN_TYPE_LINEAR: The pattern is a linear gradient, since 1.2.
 * @CAIRO_PATTERN_TYPE_RADIAL: The pattern is a radial gradient, since 1.2.
 * @CAIRO_PATTERN_TYPE_MESH: The pattern is a mesh, since 1.12.
 * @CAIRO_PATTERN_TYPE_RASTER_SOURCE: The pattern is a user pattern providing raster data, since 1.12.
 *
 * #cairo_pattern_type_t is used to describe the type of a given pattern.
 *
 * The type of a pattern is determined by the function used to create
 * it. The cairo_pattern_create_rgb() and cairo_pattern_create_rgba()
 * functions create SOLID patterns. The remaining
 * cairo_pattern_create<!-- --> functions map to pattern types in obvious
 * ways.
 *
 * The pattern type can be queried with cairo_pattern_get_type()
 *
 * Most #cairo_pattern_t functions can be called with a pattern of any
 * type, (though trying to change the extend or filter for a solid
 * pattern will have no effect). A notable exception is
 * cairo_pattern_add_color_stop_rgb() and
 * cairo_pattern_add_color_stop_rgba() which must only be called with
 * gradient patterns (either LINEAR or RADIAL). Otherwise the pattern
 * will be shutdown and put into an error state.
 *
 * New entries may be added in future versions.
 *
 * Since: 1.2
 **)
  cairo_pattern_type_t = (
    CAIRO_PATTERN_TYPE_SOLID,
    CAIRO_PATTERN_TYPE_SURFACE,
    CAIRO_PATTERN_TYPE_LINEAR,
    CAIRO_PATTERN_TYPE_RADIAL,
    CAIRO_PATTERN_TYPE_MESH,
    CAIRO_PATTERN_TYPE_RASTER_SOURCE
  );

function cairo_pattern_get_type(pattern: Pcairo_pattern_t): cairo_pattern_type_t; cdecl; external LIB_CAIRO;

procedure cairo_pattern_add_color_stop_rgb(pattern: Pcairo_pattern_t; offset: cdouble; red: cdouble; green: cdouble; blue: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_pattern_add_color_stop_rgba(pattern: Pcairo_pattern_t; offset: cdouble; red: cdouble; green: cdouble; blue: cdouble; alpha: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_mesh_pattern_begin_patch(pattern: Pcairo_pattern_t); cdecl; external LIB_CAIRO;

procedure cairo_mesh_pattern_end_patch(pattern: Pcairo_pattern_t); cdecl; external LIB_CAIRO;

procedure cairo_mesh_pattern_curve_to(pattern: Pcairo_pattern_t; x1: cdouble; y1: cdouble; x2: cdouble; y2: cdouble; x3: cdouble; y3: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_mesh_pattern_line_to(pattern: Pcairo_pattern_t; x: cdouble; y: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_mesh_pattern_move_to(pattern: Pcairo_pattern_t; x: cdouble; y: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_mesh_pattern_set_control_point(pattern: Pcairo_pattern_t; point_num: cuint; x: cdouble; y: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_mesh_pattern_set_corner_color_rgb(pattern: Pcairo_pattern_t; corner_num: cuint; red: cdouble; green: cdouble; blue: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_mesh_pattern_set_corner_color_rgba(pattern: Pcairo_pattern_t; corner_num: cuint; red: cdouble; green: cdouble; blue: cdouble; alpha: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_pattern_set_matrix(pattern: Pcairo_pattern_t; const matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_pattern_get_matrix(pattern: Pcairo_pattern_t; matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

type
(**
 * cairo_extend_t:
 * @CAIRO_EXTEND_NONE: pixels outside of the source pattern
 *   are fully transparent (Since 1.0)
 * @CAIRO_EXTEND_REPEAT: the pattern is tiled by repeating (Since 1.0)
 * @CAIRO_EXTEND_REFLECT: the pattern is tiled by reflecting
 *   at the edges (Since 1.0; but only implemented for surface patterns since 1.6)
 * @CAIRO_EXTEND_PAD: pixels outside of the pattern copy
 *   the closest pixel from the source (Since 1.2; but only
 *   implemented for surface patterns since 1.6)
 *
 * #cairo_extend_t is used to describe how pattern color/alpha will be
 * determined for areas "outside" the pattern's natural area, (for
 * example, outside the surface bounds or outside the gradient
 * geometry).
 *
 * Mesh patterns are not affected by the extend mode.
 *
 * The default extend mode is %CAIRO_EXTEND_NONE for surface patterns
 * and %CAIRO_EXTEND_PAD for gradient patterns.
 *
 * New entries may be added in future versions.
 *
 * Since: 1.0
 **)
  cairo_extend_t = (
    CAIRO_EXTEND_NONE,
    CAIRO_EXTEND_REPEAT,
    CAIRO_EXTEND_REFLECT,
    CAIRO_EXTEND_PAD
  );

procedure cairo_pattern_set_extend(pattern: Pcairo_pattern_t; extend: cairo_extend_t); cdecl; external LIB_CAIRO;

function cairo_pattern_get_extend(pattern: Pcairo_pattern_t): cairo_extend_t; cdecl; external LIB_CAIRO;

type
(**
 * cairo_filter_t:
 * @CAIRO_FILTER_FAST: A high-performance filter, with quality similar
 *     to %CAIRO_FILTER_NEAREST (Since 1.0)
 * @CAIRO_FILTER_GOOD: A reasonable-performance filter, with quality
 *     similar to %CAIRO_FILTER_BILINEAR (Since 1.0)
 * @CAIRO_FILTER_BEST: The highest-quality available, performance may
 *     not be suitable for interactive use. (Since 1.0)
 * @CAIRO_FILTER_NEAREST: Nearest-neighbor filtering (Since 1.0)
 * @CAIRO_FILTER_BILINEAR: Linear interpolation in two dimensions (Since 1.0)
 * @CAIRO_FILTER_GAUSSIAN: This filter value is currently
 *     unimplemented, and should not be used in current code. (Since 1.0)
 *
 * #cairo_filter_t is used to indicate what filtering should be
 * applied when reading pixel values from patterns. See
 * cairo_pattern_set_filter() for indicating the desired filter to be
 * used with a particular pattern.
 *
 * Since: 1.0
 **)
  cairo_filter_t = (
    CAIRO_FILTER_FAST,
    CAIRO_FILTER_GOOD,
    CAIRO_FILTER_BEST,
    CAIRO_FILTER_NEAREST,
    CAIRO_FILTER_BILINEAR,
    CAIRO_FILTER_GAUSSIAN
  );

procedure cairo_pattern_set_filter(pattern: Pcairo_pattern_t; filter: cairo_filter_t); cdecl; external LIB_CAIRO;

function cairo_pattern_get_filter(pattern: Pcairo_pattern_t): cairo_filter_t; cdecl; external LIB_CAIRO;

function cairo_pattern_get_rgba(pattern: Pcairo_pattern_t; red: pcdouble; green: pcdouble; blue: pcdouble; alpha: pcdouble): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_pattern_get_surface(pattern: Pcairo_pattern_t; surface: Pcairo_surface_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_pattern_get_color_stop_rgba(pattern: Pcairo_pattern_t; index: cint; offset: pcdouble; red: pcdouble; green: pcdouble; blue: pcdouble; alpha: pcdouble): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_pattern_get_color_stop_count(pattern: Pcairo_pattern_t; count: pcint): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_pattern_get_linear_points(pattern: Pcairo_pattern_t; x0: pcdouble; y0: pcdouble; x1: pcdouble; y1: pcdouble): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_pattern_get_radial_circles(pattern: Pcairo_pattern_t; x0: pcdouble; y0: pcdouble; r0: pcdouble; x1: pcdouble; y1: pcdouble; r1: pcdouble): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_mesh_pattern_get_patch_count(pattern: Pcairo_pattern_t; count: pcuint): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_mesh_pattern_get_path(pattern: Pcairo_pattern_t; patch_num: cuint): Pcairo_path_t ; cdecl; external LIB_CAIRO;

function cairo_mesh_pattern_get_corner_color_rgba(pattern: Pcairo_pattern_t; patch_num: cuint; corner_num: cuint; red: pcdouble; green: pcdouble; blue: pcdouble; alpha: pcdouble): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_mesh_pattern_get_control_point(pattern: Pcairo_pattern_t; patch_num: cuint; point_num: cuint; x: pcdouble; y: pcdouble): cairo_status_t; cdecl; external LIB_CAIRO;

(* Matrix functions *)

procedure cairo_matrix_init(matrix: Pcairo_matrix_t; xx: cdouble; yx: cdouble; xy: cdouble; yy: cdouble; x0: cdouble; y0: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_matrix_init_identity(matrix: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_matrix_init_translate(matrix: Pcairo_matrix_t; tx: cdouble; ty: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_matrix_init_scale(matrix: Pcairo_matrix_t; sx: cdouble; sy: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_matrix_init_rotate(matrix: Pcairo_matrix_t; radians: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_matrix_translate(matrix: Pcairo_matrix_t; tx: cdouble; ty: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_matrix_scale(matrix: Pcairo_matrix_t; sx: cdouble; sy: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_matrix_rotate(matrix: Pcairo_matrix_t; radians: cdouble); cdecl; external LIB_CAIRO;

function cairo_matrix_invert(matrix: Pcairo_matrix_t): cairo_status_t; cdecl; external LIB_CAIRO;

procedure cairo_matrix_multiply(result: Pcairo_matrix_t; const a: Pcairo_matrix_t; const b: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_matrix_transform_distance(const matrix: Pcairo_matrix_t; dx: pcdouble; dy: pcdouble); cdecl; external LIB_CAIRO;

procedure cairo_matrix_transform_point(const matrix: Pcairo_matrix_t; x: pcdouble; y: pcdouble); cdecl; external LIB_CAIRO;

(* Region functions *)

type
(**
 * cairo_region_t:
 *
 * A #cairo_region_t represents a set of integer-aligned rectangles.
 *
 * It allows set-theoretical operations like cairo_region_union() and
 * cairo_region_intersect() to be performed on them.
 *
 * Memory management of #cairo_region_t is done with
 * cairo_region_reference() and cairo_region_destroy().
 *
 * Since: 1.10
 **)
  Pcairo_region_t = ^cairo_region_t;
  cairo_region_t = record
  end;

(**
 * cairo_region_overlap_t:
 * @CAIRO_REGION_OVERLAP_IN: The contents are entirely inside the region. (Since 1.10)
 * @CAIRO_REGION_OVERLAP_OUT: The contents are entirely outside the region. (Since 1.10)
 * @CAIRO_REGION_OVERLAP_PART: The contents are partially inside and
 *     partially outside the region. (Since 1.10)
 *
 * Used as the return value for cairo_region_contains_rectangle().
 *
 * Since: 1.10
 **)
  cairo_region_overlap_t = (
    CAIRO_REGION_OVERLAP_IN, (* completely inside region *)
    CAIRO_REGION_OVERLAP_OUT, (* completely outside region *)
    CAIRO_REGION_OVERLAP_PART (* partly inside region *)
  );

function cairo_region_create(): Pcairo_region_t; cdecl; external LIB_CAIRO;

function cairo_region_create_rectangle(const rectangle: Pcairo_rectangle_int_t): Pcairo_region_t; cdecl; external LIB_CAIRO;

function cairo_region_create_rectangles(const rects: Pcairo_rectangle_int_t; count: cint): Pcairo_region_t; cdecl; external LIB_CAIRO;

function cairo_region_copy(const original: Pcairo_region_t): Pcairo_region_t; cdecl; external LIB_CAIRO;

function cairo_region_reference(region: Pcairo_region_t): Pcairo_region_t; cdecl; external LIB_CAIRO;

procedure cairo_region_destroy(region: Pcairo_region_t); cdecl; external LIB_CAIRO;

function cairo_region_equal(const a: Pcairo_region_t; const b: Pcairo_region_t): cairo_bool_t; cdecl; external LIB_CAIRO;

function cairo_region_status(const region: Pcairo_region_t): cairo_status_t; cdecl; external LIB_CAIRO;

procedure cairo_region_get_extents(const region: Pcairo_region_t; extents: Pcairo_rectangle_int_t); cdecl; external LIB_CAIRO;

function cairo_region_num_rectangles(const region: Pcairo_region_t): cint; cdecl; external LIB_CAIRO;

procedure cairo_region_get_rectangle(const region: Pcairo_region_t; nth: cint; rectangle: Pcairo_rectangle_int_t); cdecl; external LIB_CAIRO;

function cairo_region_is_empty(const region: Pcairo_region_t): cairo_bool_t; cdecl; external LIB_CAIRO;

function cairo_region_contains_rectangle(const region: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_region_overlap_t; cdecl; external LIB_CAIRO;

function cairo_region_contains_point(const region: Pcairo_region_t; x: cint; y: cint): cairo_bool_t; cdecl; external LIB_CAIRO;

procedure cairo_region_translate(region: Pcairo_region_t; dx: cint; dy: cint); cdecl; external LIB_CAIRO;

function cairo_region_subtract(dst: Pcairo_region_t; const other: Pcairo_region_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_region_subtract_rectangle(dst: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_region_intersect(dst: Pcairo_region_t; const other: Pcairo_region_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_region_intersect_rectangle(dst: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_region_union(dst: Pcairo_region_t; const other: Pcairo_region_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_region_union_rectangle(dst: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_region_xor(dst: Pcairo_region_t; const other: Pcairo_region_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_region_xor_rectangle(dst: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_status_t; cdecl; external LIB_CAIRO;

(* Functions to be used while debugging (not intended for use in production code) *)

procedure cairo_debug_reset_static_data(); cdecl; external LIB_CAIRO;

{$include cairo_deprecated.inc}


implementation


end.

