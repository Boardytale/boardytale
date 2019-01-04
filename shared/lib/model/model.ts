// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TypescriptGenerator
// **************************************************************************

export interface Image {
  id: string;
  data: string;
  multiply: number;
  width: number;
  height: number;
  top: number;
  left: number;
  name: string;
  type: ImageType;
  authorEmail: string;
  dataModelVersion: number;
  origin: string;
  created: string;
  tags: Array<string>;
}

export type ImageType =
  | "field"
  | "unitIcon"
  | "unitBase"
  | "unitHighRes"
  | "item"
  | "taleFullScreen"
  | "taleBottomScreen";

export interface User {
  id: string;
  name: string;
}
