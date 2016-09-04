//
// cairo-win32.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(* -*- Mode: c; tab-width: 8; c-basic-offset: 4; indent-tabs-mode: t; -*- *)
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
 *	Owen Taylor <otaylor@redhat.com>
 *)

unit cairo_win32;

{$mode objfpc}{$H+}

interface

{$include cairo_features.inc}

uses
  ctypes,
  cairo,
  windows;

{$ifdef CAIRO_HAS_WIN32_SURFACE}

function cairo_win32_surface_create(hdc: HDC): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_win32_surface_create_with_format(hdc: HDC; format: cairo_format_t): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_win32_printing_surface_create(hdc: HDC): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_win32_surface_create_with_ddb(hdc: HDC; format: cairo_format_t; width: cint; height: cint): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_win32_surface_create_with_dib(format: cairo_format_t; width: cint; height: cint): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_win32_surface_get_dc(surface: Pcairo_surface_t): HDC; cdecl; external LIB_CAIRO;

function cairo_win32_surface_get_image(surface: Pcairo_surface_t): Pcairo_surface_t; cdecl; external LIB_CAIRO;

{$ifdef CAIRO_HAS_WIN32_FONT}

(*
 * Win32 font support
 *)

function cairo_win32_font_face_create_for_logfontw(logfont: PLOGFONTW): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

function cairo_win32_font_face_create_for_hfont(font: HFONT): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

function cairo_win32_font_face_create_for_logfontw_hfont(logfont: PLOGFONTW; font: HFONT): Pcairo_font_face_t; cdecl; external LIB_CAIRO;

function cairo_win32_scaled_font_select_font(scaled_font: Pcairo_scaled_font_t; hdc: HDC): cairo_status_t; cdecl; external LIB_CAIRO;

procedure cairo_win32_scaled_font_done_font(scaled_font: Pcairo_scaled_font_t); cdecl; external LIB_CAIRO;

function cairo_win32_scaled_font_get_metrics_factor(scaled_font: Pcairo_scaled_font_t): cdouble; cdecl; external LIB_CAIRO;

procedure cairo_win32_scaled_font_get_logical_to_device(scaled_font: Pcairo_scaled_font_t; logical_to_device: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

procedure cairo_win32_scaled_font_get_device_to_logical(scaled_font: Pcairo_scaled_font_t; device_to_logical: Pcairo_matrix_t); cdecl; external LIB_CAIRO;

{$endif} (* CAIRO_HAS_WIN32_FONT *)

{$else} (* CAIRO_HAS_WIN32_SURFACE *)
// # error Cairo was not compiled with support for the win32 backend
{$endif} (* CAIRO_HAS_WIN32_SURFACE *)


implementation


end.

