//
// cairo-pdf.h header binding for the Free Pascal Compiler aka FPC
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
 *  Carl D. Worth <cworth@cworth.org>
 *)

unit cairo_pdf;

{$mode objfpc}{$H+}

interface

{$include cairo_features.inc}

uses
  ctypes,
  cairo;

{$ifdef CAIRO_HAS_PDF_SURFACE}

(**
 * cairo_pdf_version_t:
 * @CAIRO_PDF_VERSION_1_4: The version 1.4 of the PDF specification. (Since 1.10)
 * @CAIRO_PDF_VERSION_1_5: The version 1.5 of the PDF specification. (Since 1.10)
 *
 * #cairo_pdf_version_t is used to describe the version number of the PDF
 * specification that a generated PDF file will conform to.
 *
 * Since: 1.10
 **)
type
  Pcairo_pdf_version_t = ^cairo_pdf_version_t;
  PPcairo_pdf_version_t = ^Pcairo_pdf_version_t;
  cairo_pdf_version_t = (
    CAIRO_PDF_VERSION_1_4,
    CAIRO_PDF_VERSION_1_5
  );

function cairo_pdf_surface_create(const filename: pchar; width_in_points: cdouble; height_in_points: cdouble): Pcairo_surface_t; cdecl; external LIB_CAIRO;

function cairo_pdf_surface_create_for_stream(write_func: cairo_write_func_t; closure: pointer; width_in_points: cdouble; height_in_points: cdouble): Pcairo_surface_t; cdecl; external LIB_CAIRO;

procedure cairo_pdf_surface_restrict_to_version(surface: Pcairo_surface_t; version: cairo_pdf_version_t); cdecl; external LIB_CAIRO;

procedure cairo_pdf_get_versions(const versions: PPcairo_pdf_version_t; num_versions: pcint); cdecl; external LIB_CAIRO;

function cairo_pdf_version_to_string(version: cairo_pdf_version_t): pchar; cdecl; external LIB_CAIRO;

procedure cairo_pdf_surface_set_size(surface: Pcairo_surface_t; width_in_points: cdouble; height_in_points: cdouble); cdecl; external LIB_CAIRO;

(**
 * cairo_pdf_outline_flags_t:
 * @CAIRO_PDF_OUTLINE_FLAG_OPEN: The outline item defaults to open in the PDF viewer (Since 1.16)
 * @CAIRO_PDF_OUTLINE_FLAG_BOLD: The outline item is displayed by the viewer in bold text (Since 1.16)
 * @CAIRO_PDF_OUTLINE_FLAG_ITALIC: The outline item is displayed by the viewer in italic text (Since 1.16)
 *
 * #cairo_pdf_outline_flags_t is used by the
 * cairo_pdf_surface_add_outline() function specify the attributes of
 * an outline item. These flags may be bitwise-or'd to produce any
 * combination of flags.
 *
 * Since: 1.16
 **)
type
  cairo_pdf_outline_flags_t = (
    CAIRO_PDF_OUTLINE_FLAG_OPEN   = $1,
    CAIRO_PDF_OUTLINE_FLAG_BOLD   = $2,
    CAIRO_PDF_OUTLINE_FLAG_ITALIC = $4
  );

const
  CAIRO_PDF_OUTLINE_ROOT = 0;

function cairo_pdf_surface_add_outline (surface: Pcairo_surface_t; parent_id: cint; const utf8: pchar; const dest: pchar; flags: cairo_pdf_outline_flags_t): cint; cdecl; external LIB_CAIRO;

(**
 * cairo_pdf_metadata_t:
 * @CAIRO_PDF_METADATA_TITLE: The document title (Since 1.16)
 * @CAIRO_PDF_METADATA_AUTHOR: The document author (Since 1.16)
 * @CAIRO_PDF_METADATA_SUBJECT: The document subject (Since 1.16)
 * @CAIRO_PDF_METADATA_KEYWORDS: The document keywords (Since 1.16)
 * @CAIRO_PDF_METADATA_CREATOR: The document creator (Since 1.16)
 * @CAIRO_PDF_METADATA_CREATE_DATE: The document creation date (Since 1.16)
 * @CAIRO_PDF_METADATA_MOD_DATE: The document modification date (Since 1.16)
 *
 * #cairo_pdf_metadata_t is used by the
 * cairo_pdf_surface_set_metadata() function specify the metadata to set.
 *
 * Since: 1.16
 **)
type
  cairo_pdf_metadata_t = (
    CAIRO_PDF_METADATA_TITLE,
    CAIRO_PDF_METADATA_AUTHOR,
    CAIRO_PDF_METADATA_SUBJECT,
    CAIRO_PDF_METADATA_KEYWORDS,
    CAIRO_PDF_METADATA_CREATOR,
    CAIRO_PDF_METADATA_CREATE_DATE,
    CAIRO_PDF_METADATA_MOD_DATE
  );

procedure cairo_pdf_surface_set_metadata(surface: Pcairo_surface_t; metadata: cairo_pdf_metadata_t; const utf8: pchar); cdecl; external LIB_CAIRO;

procedure cairo_pdf_surface_set_page_label(surface: Pcairo_surface_t; const utf8: pchar); cdecl; external LIB_CAIRO;

procedure cairo_pdf_surface_set_thumbnail_size(surface: Pcairo_surface_t; width: cint; height: cint); cdecl; external LIB_CAIRO;

{$else} (* CAIRO_HAS_PDF_SURFACE *)
// # error Cairo was not compiled with support for the pdf backend
{$endif} (* CAIRO_HAS_PDF_SURFACE *)


implementation


end.

