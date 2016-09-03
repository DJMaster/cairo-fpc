//
// cairo-ps.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(* cairo - a vector graphics library with display and print output
 *
 * Copyright © 2002 University of Southern California
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
 *	Carl D. Worth <cworth@cworth.org>
 *)

unit cairo_ps;

{$mode objfpc}{$H+}

interface

{$include cairo_features.inc}

uses
  ctypes,
  cairo;

{$ifdef CAIRO_HAS_PS_SURFACE}

// #include <stdio.h>

(* PS-surface functions *)

(**
 * cairo_ps_level_t:
 * @CAIRO_PS_LEVEL_2: The language level 2 of the PostScript specification. (Since 1.6)
 * @CAIRO_PS_LEVEL_3: The language level 3 of the PostScript specification. (Since 1.6)
 *
 * #cairo_ps_level_t is used to describe the language level of the
 * PostScript Language Reference that a generated PostScript file will
 * conform to.
 *
 * Since: 1.6
 **)
type
  Pcairo_ps_level_t = ^cairo_ps_level_t;
  PPcairo_ps_level_t = ^Pcairo_ps_level_t;
  cairo_ps_level_t = (
    CAIRO_PS_LEVEL_2,
    CAIRO_PS_LEVEL_3
  );

function cairo_ps_surface_create(const filename: pchar; width_in_points: cdouble; height_in_points: cdouble): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_ps_surface_create_for_stream(write_func: cairo_write_func_t; closure: pointer; width_in_points: cdouble; height_in_points: cdouble): Pcairo_surface_t; cdecl; external LIB_CAIRO;

procedure cairo_ps_surface_restrict_to_level(surface: Pcairo_surface_t; level: cairo_ps_level_t); cdecl; external LIB_CAIRO;

procedure cairo_ps_get_levels(const  levels: PPcairo_ps_level_t; num_levels: pcint); cdecl; external LIB_CAIRO;

function cairo_ps_level_to_string(level: cairo_ps_level_t): pchar; cdecl; external LIB_CAIRO;

procedure cairo_ps_surface_set_eps(surface: Pcairo_surface_t; eps: cairo_bool_t); cdecl; external LIB_CAIRO;

function cairo_ps_surface_get_eps(surface: Pcairo_surface_t): cairo_bool_t; cdecl; external LIB_CAIRO;

procedure cairo_ps_surface_set_size(surface: Pcairo_surface_t; width_in_points: cdouble; height_in_points: cdouble); cdecl; external LIB_CAIRO;

procedure cairo_ps_surface_dsc_comment (surface: Pcairo_surface_t; const comment: pchar); cdecl; external LIB_CAIRO;

procedure cairo_ps_surface_dsc_begin_setup (surface: Pcairo_surface_t); cdecl; external LIB_CAIRO;

procedure cairo_ps_surface_dsc_begin_page_setup (surface: Pcairo_surface_t); cdecl; external LIB_CAIRO;

{$else} (* CAIRO_HAS_PS_SURFACE *)
// # error Cairo was not compiled with support for the ps backend
{$endif} (* CAIRO_HAS_PS_SURFACE *)


implementation


end.

