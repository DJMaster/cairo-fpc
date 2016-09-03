//
// cairo-ft.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(* cairo - a vector graphics library with display and print output
 *
 * Copyright © 2005 Red Hat, Inc
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
 * The Initial Developer of the Original Code is Red Hat, Inc.
 *
 * Contributor(s):
 *  Graydon Hoare <graydon@redhat.com>
 *	Owen Taylor <otaylor@redhat.com>
 *)

unit cairo_ft;

{$mode objfpc}{$H+}

interface

{$include cairo_features.inc}

uses
  ctypes,
  cairo;

{$ifdef CAIRO_HAS_FT_FONT}

(* Fontconfig/Freetype platform-specific font interface *)

type
  FT_Face = pointer;
  PFcPattern = pointer;

// #include <ft2build.h>
// #include FT_FREETYPE_H

// #if CAIRO_HAS_FC_FONT
// #include <fontconfig/fontconfig.h>
// #endif

function cairo_ft_font_face_create_for_ft_face (face: FT_Face; load_flags: cint): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

(**
 * cairo_ft_synthesize_t:
 * @CAIRO_FT_SYNTHESIZE_BOLD: Embolden the glyphs (redraw with a pixel offset)
 * @CAIRO_FT_SYNTHESIZE_OBLIQUE: Slant the glyph outline by 12 degrees to the
 * right.
 *
 * A set of synthesis options to control how FreeType renders the glyphs
 * for a particular font face.
 *
 * Individual synthesis features of a #cairo_ft_font_face_t can be set
 * using cairo_ft_font_face_set_synthesize(), or disabled using
 * cairo_ft_font_face_unset_synthesize(). The currently enabled set of
 * synthesis options can be queried with cairo_ft_font_face_get_synthesize().
 *
 * Note: that when synthesizing glyphs, the font metrics returned will only
 * be estimates.
 *
 * Since: 1.12
 **)
type
  cairo_ft_synthesize_t = (
    CAIRO_FT_SYNTHESIZE_BOLD = 1 shl 0,
    CAIRO_FT_SYNTHESIZE_OBLIQUE = 1 shl 1
  );

procedure cairo_ft_font_face_set_synthesize(font_face: Pcairo_font_face_t; synth_flags: cuint); cdecl; external LIB_CAIRO;

procedure cairo_ft_font_face_unset_synthesize(font_face: Pcairo_font_face_t; synth_flags: cuint); cdecl; external LIB_CAIRO;

function cairo_ft_font_face_get_synthesize(font_face: Pcairo_font_face_t): cuint; cdecl; external LIB_CAIRO;

function cairo_ft_scaled_font_lock_face(scaled_font: Pcairo_scaled_font_t): FT_Face; cdecl; external LIB_CAIRO;

procedure cairo_ft_scaled_font_unlock_face(scaled_font: Pcairo_scaled_font_t); cdecl; external LIB_CAIRO;

{$ifdef CAIRO_HAS_FC_FONT}

function cairo_ft_font_face_create_for_pattern(pattern: PFcPattern): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

procedure cairo_ft_font_options_substitute(const options: Pcairo_font_options_t; pattern: PFcPattern); cdecl; external LIB_CAIRO;

{$endif}

{$else}  (* CAIRO_HAS_FT_FONT *)
// # error Cairo was not compiled with support for the freetype font backend
{$endif} (* CAIRO_HAS_FT_FONT *)


implementation


end.

