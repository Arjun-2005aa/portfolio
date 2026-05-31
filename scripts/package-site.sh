#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPLOY_DIR="$ROOT_DIR/deploy"
ZIP_PATH="$ROOT_DIR/portfolio-deploy.zip"

FILES=(
  "about.html"
  "contact.html"
  "index.html"
  "project-drone.html"
  "project-flexml.html"
  "project-power-system.html"
  "project-team-tedh.html"
  "project-water-ai.html"
  "projects.html"
  "script.js"
  "styles.css"
  "myphoto.jpeg"
  "KasimsettyVenkataNagaArjun_CV_Academy.pdf"
  "PhotosAndVideos/FlexML/infarence_deeplabV3_mlmodel.PNG"
  "PhotosAndVideos/FlexML/infarence_yolov8_mlmodel.PNG"
  "PhotosAndVideos/FlexML/mainview.jpg"
  "PhotosAndVideos/FlexML/model_selection_files.PNG"
  "PhotosAndVideos/FlexML/myinfopage.PNG"
  "PhotosAndVideos/Gps_denied_Navigation/3d_mapcompilation _in_reality capture.mp4"
  "PhotosAndVideos/Gps_denied_Navigation/GPS_DENIED_Navigation_SIMULATON.mp4"
  "PhotosAndVideos/Gps_denied_Navigation/Gpsdenied navigation Image.png"
  "PhotosAndVideos/TEAM TEDH/APPoliceDepartment_temaTEDH.JPG"
  "PhotosAndVideos/TEAM TEDH/APdroneCorparation_tedh_presentation.jpg"
  "PhotosAndVideos/TEAM TEDH/AmarathiDroneSummit_tedh.JPG"
  "PhotosAndVideos/TEAM TEDH/Dronefusion_certificates andPricemoney.JPG"
  "PhotosAndVideos/TEAM TEDH/Hacksrm_teamTedh_groupPhoto.JPEG"
  "PhotosAndVideos/TEAM TEDH/Hacksrm_teamTedh_groupPhoto_withWinningCheck.JPG"
  "PhotosAndVideos/TEAM TEDH/SmartIndiaHackathon_temaTEDH_groupimage.JPG"
  "PhotosAndVideos/TEAM TEDH/SmartIndiaHackathon_temaTEDH_groupimage_withCertificates.JPG"
  "PhotosAndVideos/TEAM TEDH/TeamTedh_DroneFusionAll winners.JPG"
  "PhotosAndVideos/TEAM TEDH/TeamTedh_researchDaySpetialMentaionforWaterAI.JPEG"
  "PhotosAndVideos/TEAM TEDH/tedh-logo.png"
  "PhotosAndVideos/TetheredDroneSystem/Tether_AIRUnit_pcb.jpg.jpg"
  "PhotosAndVideos/TetheredDroneSystem/Tether_LowweightDroneCadImage.jpg.jpg"
  "PhotosAndVideos/TetheredDroneSystem/Tether_LowweightDroneFab_inprogress_Image.jpg.jpg"
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

mkdir -p "$DEPLOY_DIR"

for rel_path in "${FILES[@]}"; do
  src_path="$ROOT_DIR/$rel_path"
  dest_path="$DEPLOY_DIR/$rel_path"

  if [[ ! -f "$src_path" ]]; then
    printf 'Missing file: %s\n' "$rel_path" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$dest_path")"
  cp -f "$src_path" "$dest_path"
done

(
  cd "$DEPLOY_DIR"
  zip -rq "$ZIP_PATH" .
)

printf 'Deploy folder ready at %s\n' "$DEPLOY_DIR"
printf 'Zip ready at %s\n' "$ZIP_PATH"
