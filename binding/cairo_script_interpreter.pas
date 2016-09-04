//
// cairo-script-interpreter.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(* cairo - a vector graphics library with display and print output
 *
 * Copyright © 2008 Chris Wilson
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
 * The Initial Developer of the Original Code is Chris Wilson
 *
 * Contributor(s):
 *	Chris Wilson <chris@chris-wilson.co.uk>
 *)

unit cairo_script_interpreter;

{$mode objfpc}{$H+}

interface

{$include cairo_features.inc}

uses
  ctypes,
  cairo;

// #include <stdio.h>

type
  Pcairo_script_interpreter_t = ^cairo_script_interpreter_t;
  cairo_script_interpreter_t = record
  end;

(* XXX expose csi_dictionary_t and pass to hooks *)
type
  csi_destroy_func_t = procedure (closure: pointer; ptr: pointer);
  csi_surface_create_func_t = function (closure: pointer; content: cairo_content_t; width: cdouble; height: cdouble; uid: clong): Pcairo_surface_t;
  csi_context_create_func_t = function (closure: pointer; surface: Pcairo_surface_t): Pcairo_t;
  csi_show_page_func_t = procedure(closure: pointer; cr: Pcairo_t);
  csi_copy_page_func_t = procedure (closure: pointer; cr: Pcairo_t);
  csi_create_source_image_t = function (closure: pointer; format: cairo_format_t; width: cint; height: cint; uid: clong): Pcairo_surface_t;

type
  Pcairo_script_interpreter_hooks_t = ^cairo_script_interpreter_hooks_t;
  cairo_script_interpreter_hooks_t = record
    closure: pointer;
    surface_create: csi_surface_create_func_t;
    surface_destroy: csi_destroy_func_t;
    context_create: csi_context_create_func_t;
    context_destroy: csi_destroy_func_t;
    show_page: csi_show_page_func_t;
    copy_page: csi_copy_page_func_t;
    create_source_image: csi_create_source_image_t;
  end;

function cairo_script_interpreter_create(): Pcairo_script_interpreter_t; cdecl; external LIB_CAIRO;

procedure cairo_script_interpreter_install_hooks(ctx: Pcairo_script_interpreter_t; const hooks: Pcairo_script_interpreter_hooks_t); cdecl; external LIB_CAIRO;

function cairo_script_interpreter_run(ctx: Pcairo_script_interpreter_t; const filename: pchar): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_script_interpreter_feed_stream(ctx: Pcairo_script_interpreter_t; var stream: file): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_script_interpreter_feed_string(ctx: Pcairo_script_interpreter_t; const line: pchar; len: cint): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_script_interpreter_get_line_number(ctx: Pcairo_script_interpreter_t): cuint; cdecl; external LIB_CAIRO;

function cairo_script_interpreter_reference(ctx: Pcairo_script_interpreter_t): Pcairo_script_interpreter_t; cdecl; external LIB_CAIRO;

function cairo_script_interpreter_finish(ctx: Pcairo_script_interpreter_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_script_interpreter_destroy(ctx: Pcairo_script_interpreter_t): cairo_status_t; cdecl; external LIB_CAIRO;

function cairo_script_interpreter_translate_stream(var stream: file; write_func: cairo_write_func_t; closure: pointer): cairo_status_t; cdecl; external LIB_CAIRO;


implementation


end.

