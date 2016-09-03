//
// cairo-gobject.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(* cairo - a vector graphics library with display and print output
 *
 * Copyright © 2010 Red Hat Inc.
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
 *	Benjamin Otte <otte@redhat.com>
 *)

unit cairo_gobject;

{$mode objfpc}{$H+}

interface

{$include cairo_features.inc}

uses
  ctypes,
  cairo,
  glib2;

{$ifdef CAIRO_HAS_GOBJECT_FUNCTIONS}

(* structs *)

function CAIRO_GOBJECT_TYPE_CONTEXT(): GType;
function cairo_gobject_context_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_DEVICE(): GType;
function cairo_gobject_device_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_MATRIX(): GType;
function cairo_gobject_matrix_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_PATTERN(): GType;
function cairo_gobject_pattern_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_SURFACE(): GType;
function cairo_gobject_surface_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_RECTANGLE(): GType;
function cairo_gobject_rectangle_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_SCALED_FONT(): GType;
function cairo_gobject_scaled_font_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_FONT_FACE(): GType;
function cairo_gobject_font_face_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_FONT_OPTIONS(): GType;
function cairo_gobject_font_options_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_RECTANGLE_INT(): GType;
function cairo_gobject_rectangle_int_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_REGION(): GType;
function cairo_gobject_region_get_type(): GType; cdecl; external LIB_CAIRO;

(* enums *)

function CAIRO_GOBJECT_TYPE_STATUS(): GType;
function cairo_gobject_status_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_CONTENT(): GType;
function cairo_gobject_content_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_OPERATOR(): GType;
function cairo_gobject_operator_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_ANTIALIAS(): GType;
function cairo_gobject_antialias_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_FILL_RULE(): GType;
function cairo_gobject_fill_rule_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_LINE_CAP(): GType;
function cairo_gobject_line_cap_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_LINE_JOIN(): GType;
function cairo_gobject_line_join_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_TEXT_CLUSTER_FLAGS(): GType;
function cairo_gobject_text_cluster_flags_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_FONT_SLANT(): GType;
function cairo_gobject_font_slant_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_FONT_WEIGHT(): GType;
function cairo_gobject_font_weight_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_SUBPIXEL_ORDER(): GType;
function cairo_gobject_subpixel_order_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_HINT_STYLE(): GType;
function cairo_gobject_hint_style_get_type(): GType; cdecl; external LIB_CAIRO;

(* historical accident *)
function CAIRO_GOBJECT_TYPE_HNT_METRICS(): GType;
function CAIRO_GOBJECT_TYPE_HINT_METRICS(): GType;
function cairo_gobject_hint_metrics_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_FONT_TYPE(): GType;
function cairo_gobject_font_type_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_PATH_DATA_TYPE(): GType;
function cairo_gobject_path_data_type_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_DEVICE_TYPE(): GType;
function cairo_gobject_device_type_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_SURFACE_TYPE(): GType;
function cairo_gobject_surface_type_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_FORMAT(): GType;
function cairo_gobject_format_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_PATTERN_TYPE(): GType;
function cairo_gobject_pattern_type_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_EXTEND(): GType;
function cairo_gobject_extend_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_FILTER(): GType;
function cairo_gobject_filter_get_type(): GType; cdecl; external LIB_CAIRO;

function CAIRO_GOBJECT_TYPE_REGION_OVERLAP(): GType;
function cairo_gobject_region_overlap_get_type(): GType; cdecl; external LIB_CAIRO;

{$else} (* CAIRO_HAS_GOBJECT_FUNCTIONS *)
// # error Cairo was not compiled with support for GObject
{$endif} (* CAIRO_HAS_GOBJECT_FUNCTIONS *)

implementation

function CAIRO_GOBJECT_TYPE_CONTEXT(): GType;
begin
  Result := cairo_gobject_context_get_type();
end;

function CAIRO_GOBJECT_TYPE_DEVICE(): GType;
begin
  Result := cairo_gobject_device_get_type();
end;

function CAIRO_GOBJECT_TYPE_MATRIX(): GType;
begin
  Result := cairo_gobject_matrix_get_type();
end;

function CAIRO_GOBJECT_TYPE_PATTERN(): GType;
begin
  Result := cairo_gobject_pattern_get_type();
end;

function CAIRO_GOBJECT_TYPE_SURFACE(): GType;
begin
  Result := cairo_gobject_surface_get_type();
end;

function CAIRO_GOBJECT_TYPE_RECTANGLE(): GType;
begin
  Result := cairo_gobject_rectangle_get_type();
end;

function CAIRO_GOBJECT_TYPE_SCALED_FONT(): GType;
begin
  Result := cairo_gobject_scaled_font_get_type();
end;

function CAIRO_GOBJECT_TYPE_FONT_FACE(): GType;
begin
  Result := cairo_gobject_font_face_get_type();
end;

function CAIRO_GOBJECT_TYPE_FONT_OPTIONS(): GType;
begin
  Result := cairo_gobject_font_options_get_type();
end;

function CAIRO_GOBJECT_TYPE_RECTANGLE_INT(): GType;
begin
  Result := cairo_gobject_rectangle_int_get_type();
end;

function CAIRO_GOBJECT_TYPE_REGION(): GType;
begin
  Result := cairo_gobject_region_get_type();
end;

(* enums *)

function CAIRO_GOBJECT_TYPE_STATUS(): GType;
begin
  Result := cairo_gobject_status_get_type();
end;

function CAIRO_GOBJECT_TYPE_CONTENT(): GType;
begin
  Result := cairo_gobject_content_get_type();
end;

function CAIRO_GOBJECT_TYPE_OPERATOR(): GType;
begin
  Result := cairo_gobject_operator_get_type();
end;

function CAIRO_GOBJECT_TYPE_ANTIALIAS(): GType;
begin
  Result := cairo_gobject_antialias_get_type();
end;

function CAIRO_GOBJECT_TYPE_FILL_RULE(): GType;
begin
  Result := cairo_gobject_fill_rule_get_type();
end;

function CAIRO_GOBJECT_TYPE_LINE_CAP(): GType;
begin
  Result := cairo_gobject_line_cap_get_type();
end;

function CAIRO_GOBJECT_TYPE_LINE_JOIN(): GType;
begin
  Result := cairo_gobject_line_join_get_type();
end;

function CAIRO_GOBJECT_TYPE_TEXT_CLUSTER_FLAGS(): GType;
begin
  Result := cairo_gobject_text_cluster_flags_get_type();
end;

function CAIRO_GOBJECT_TYPE_FONT_SLANT(): GType;
begin
  Result := cairo_gobject_font_slant_get_type();
end;

function CAIRO_GOBJECT_TYPE_FONT_WEIGHT(): GType;
begin
  Result := cairo_gobject_font_weight_get_type();
end;

function CAIRO_GOBJECT_TYPE_SUBPIXEL_ORDER(): GType;
begin
  Result := cairo_gobject_subpixel_order_get_type();
end;

function CAIRO_GOBJECT_TYPE_HINT_STYLE(): GType;
begin
  Result := cairo_gobject_hint_style_get_type();
end;

(* historical accident *)

function CAIRO_GOBJECT_TYPE_HNT_METRICS(): GType;
begin
  Result := cairo_gobject_hint_metrics_get_type();
end;
  
function  CAIRO_GOBJECT_TYPE_HINT_METRICS(): GType;
begin
  Result := cairo_gobject_hint_metrics_get_type();
end;

function CAIRO_GOBJECT_TYPE_FONT_TYPE(): GType;
begin
  Result := cairo_gobject_font_type_get_type();
end;

function CAIRO_GOBJECT_TYPE_PATH_DATA_TYPE(): GType;
begin
  Result := cairo_gobject_path_data_type_get_type();
end;

function CAIRO_GOBJECT_TYPE_DEVICE_TYPE(): GType;
begin
  Result := cairo_gobject_device_type_get_type();
end;

function CAIRO_GOBJECT_TYPE_SURFACE_TYPE(): GType;
begin
  Result := cairo_gobject_surface_type_get_type();
end;

function CAIRO_GOBJECT_TYPE_FORMAT(): GType;
begin
  Result := cairo_gobject_format_get_type();
end;

function CAIRO_GOBJECT_TYPE_PATTERN_TYPE(): GType;
begin
  Result := cairo_gobject_pattern_type_get_type();
end;

function CAIRO_GOBJECT_TYPE_EXTEND(): GType;
begin
  Result := cairo_gobject_extend_get_type();
end;

function CAIRO_GOBJECT_TYPE_FILTER(): GType;
begin
  Result := cairo_gobject_filter_get_type();
end;

function CAIRO_GOBJECT_TYPE_REGION_OVERLAP(): GType;
begin
  Result := cairo_gobject_region_overlap_get_type();
end;

end.

