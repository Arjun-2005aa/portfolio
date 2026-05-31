#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_LONGEST_SIDE="${1:-1600}"

FILES=(
  "PhotosAndVideos/FlexML/infarence_deeplabV3_mlmodel.jpg"
  "PhotosAndVideos/FlexML/infarence_yolov8_mlmodel.jpg"
  "PhotosAndVideos/FlexML/mainview.jpg"
  "PhotosAndVideos/FlexML/model_selection_files.jpg"
  "PhotosAndVideos/FlexML/myinfopage.jpg"
  "PhotosAndVideos/Gps_denied_Navigation/Gpsdenied navigation Image.jpg"
  "PhotosAndVideos/TEAM TEDH/APPoliceDepartment_temaTEDH.JPG"
  "PhotosAndVideos/TEAM TEDH/APdroneCorparation_tedh_presentation.jpg"
  "PhotosAndVideos/TEAM TEDH/Dronefusion_certificates andPricemoney.JPG"
  "PhotosAndVideos/TEAM TEDH/Hacksrm_teamTedh_groupPhoto.JPEG"
  "PhotosAndVideos/TEAM TEDH/Hacksrm_teamTedh_groupPhoto_withWinningCheck.JPG"
  "PhotosAndVideos/TEAM TEDH/SmartIndiaHackathon_temaTEDH_groupimage.JPG"
  "PhotosAndVideos/TEAM TEDH/SmartIndiaHackathon_temaTEDH_groupimage_withCertificates.JPG"
  "PhotosAndVideos/TEAM TEDH/TeamTedh_DroneFusionAll winners.JPG"
  "PhotosAndVideos/TEAM TEDH/TeamTedh_researchDaySpetialMentaionforWaterAI.JPEG"
  "PhotosAndVideos/TetheredDroneSystem/Tether_AIRUnit_pcb.jpg.jpg"
  "PhotosAndVideos/TetheredDroneSystem/Tether_groundstation_pcb.jpg"
  "PhotosAndVideos/Water AI/Hardware Images/85FE40DF-811B-48ED-9CED-C6A35167B29D.JPG"
  "PhotosAndVideos/Water AI/Hardware Images/IMG_4441.jpg"
  "PhotosAndVideos/Water AI/web/camera-sample-view.jpg"
  "PhotosAndVideos/Water AI/web/field-collection-1.jpg"
  "PhotosAndVideos/Water AI/web/field-collection-2.jpg"
  "PhotosAndVideos/Water AI/web/field-collection-3.jpg"
  "PhotosAndVideos/Water AI/web/field-collection-4.jpg"
  "PhotosAndVideos/Water AI/web/field-collection-5.jpg"
  "PhotosAndVideos/Water AI/web/lab-parameter-instrument.jpg"
)

for rel_path in "${FILES[@]}"; do
  abs_path="$ROOT_DIR/$rel_path"

  if [[ ! -f "$abs_path" ]]; then
    printf 'Missing file: %s\n' "$rel_path" >&2
    exit 1
  fi

  width="$(sips -g pixelWidth "$abs_path" 2>/dev/null | awk '/pixelWidth/ {print $2}')"
  height="$(sips -g pixelHeight "$abs_path" 2>/dev/null | awk '/pixelHeight/ {print $2}')"
  longest_side="$width"
  if (( height > longest_side )); then
    longest_side="$height"
  fi

  if (( longest_side <= TARGET_LONGEST_SIDE )); then
    printf 'Skipped %s (%sx%s)\n' "$rel_path" "$width" "$height"
    continue
  fi

  tmp_path="$(mktemp "/tmp/resize-site-image.XXXXXX.jpg")"
  sips -Z "$TARGET_LONGEST_SIDE" -s format jpeg --setProperty formatOptions 72 "$abs_path" --out "$tmp_path" >/dev/null
  mv "$tmp_path" "$abs_path"
  printf 'Resized %s (%sx%s -> longest side %s)\n' "$rel_path" "$width" "$height" "$TARGET_LONGEST_SIDE"
done
