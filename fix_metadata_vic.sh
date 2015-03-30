#!/bin/sh

#updates metadata in netcdfs according to suggestions at
#http://www.unidata.ucar.edu/software/thredds/current/netcdf-java/formats/DataDiscoveryAttConvention.html
#and consistent with other projects in Integrate Scenarios of Pacific Northwest

#notes: if the attribute is not currently in the file, we have to create the attribute with mode c like:
#ncatted -O -h -a publisher_email,global,c,c,"$PUBLISHEREMAIL" $i
#whereas if it already exists, we just have to modify it with mode m like:
#ncatted -O -h -a publisher_email,global,m,c,"$PUBLISHEREMAIL" $i
#however.. we can just use create c on everything and it will all work just fine
#but if we know that the files already have a field, using mode m might increase the speed

#========================================================
#    REPLACEMENTS
#========================================================
TITLE="Variable Infiltration Capacity (VIC 4.1.2.1) hydrologic simulations using MACA-Livneh CMIP5 forcings over the western U.S"
SUMMARY="This archive contains hydrologic fluxes and state variables at 1/16-degree resolution for the western United States produced with the Variable Infiltration Capacity (VIC; Liang et al 1994) model. VIC is a macroscale hydrologic model that solves the water and energy balance at each model grid cell and incorporates spatially distributed parameters describing topography, soils, and vegetation. The simulations were forced with statistically downscaled global climate model (GCM) simulations using the method of Multivariate Adaptive Constructed Analogs (MACAv2-Livneh; Abatzoglou and Brown 2012) and trained to Livneh et al (2013) gridded surface observations. Four downscaled meteorological variables were used at a daily timestep: (1) minimum temperature and (2) maximum temperature, (2) precipitation, and (3) average wind speed. The other variables of (1) radiation and (2) specific humidity at a daily timestep were derived using the MTCLIM (Glassy et al, 1994) algorithm. The downscaled forcings were constructed using 365-day global climate model (GCM) outputs from the Coupled Model Inter-comparison Project Phase (CMIP5). The simulations span a historical period (1950-2005) and a future period (2006-2099). For the future period, two emission scenarios were used (RCP 4.5/8.5)."
KEYWORDS="Hydrology, VIC, Variable Infiltration Capacity Model, CMIP5, MACA statistical downscaling, water evaporation flux, surface runoff flux, subsurface runoff flux, snow melt flux, soil moisture content per layer, soil temperature per layer, liquid water content of snow, net heat flux into ground, surface upward latent heat flux, surface upward latent heat from sublimation flux, surface upward sensible heat flux, effective skin temperature, incoming downward shortwave flux, incoming downward longwave flux, net downward shortwave flux, net downward longwave flux, net downward radiation flux, precipitation flux, specific humidity, potential evaporation flux saturated soil, potential evaporation flux open water, potential evaporation flux shortref grass, potential evaporation flux tallref alfalfa, potential evaporation  flux natural vegetation, transpiration flux, runoff flux, soil moisture content, Evaporation, Ground, Latent, LatentSub, Longwave, LongwaveNet, petH2OSurf, petNatVeg, petSatSoil, petShort, petTall, Precip, Qair, Qs, Qsb, Qsm, Rnet, Sensible, Shortwave, ShortwaveNet, SoilMoist, SoilTemp, SurfTemp, SWE, Transp, TotalSoilMoist, TotalRunoff"

#=============
#  RECOMMENDED 
#=============
ID="Blank";  #leave blank, NKN will have to fix later
NAMINGAUTHORITY="edu.uidaho.nkn"
KEYWORDS_VOCABULARY="None"
CDM_DATA_TYPE="GRID";
HISTORY="Created by by Matt Stumbaugh, University of Washington, Civil and Environmental Engineering, Land Surface Hydrology Group"


DATE_CREATED=" - - "
CREATOR_NAME=""
CREATOR_URL=""
CREATOR_ROLE="Principal Investigator";
CREATOR_EMAIL=""
#INSTITUTION="University of Washington";
PROJECT="Integrated Scenarios Project of the Northwest Climate Sciences Center"
PROCESSING_LEVEL="Gridded Hydrologic Projections";
ACKNOWLEDGMENT="Please reference the Northwest Climate Science Center (NW CSC) US Geological Survey Grant Number G12AC20495 and the references included herein. We acknowledge the World Climate Research Programme's Working Group on Coupled Modeling, which is responsible for CMIP, and we thank the climate modeling groups for producing and making available their model output. For CMIP, the U.S. Department of Energy's Program for Climate Model Diagnosis and Intercomparison provides coordinating support and led development of software infrastructure in partnership with the Global Organization for Earth System Science Portals."

#hard coded down below  (need to change these for VIC... WUSA not CONUS)
#GEOSPATIAL_LAT_MIN=25.2
#GEOSPATIAL_LAT_MAX=52.8
#GEOSPATIAL_LON_MIN=-67
#GEOSPATIAL_LON_MAX=-125
#GEOSPATIAL_VERTICAL_MIN=0
#GEOSPATIAL_VERTICAL_MAX=0

#these vary depending on the file, but this is done correctly in the current files
#TIME_COVERAGE_START="1950-01-01T00:00";
#TIME_COVERAGE_END="2099-12-31T00:00";
#TIME_COVERAGE_DURATION="P20Y";  #for most files except end ones
#TIME_COVERAGE_RESOLUTION="P1D";

STANDARD_NAME_VOCABULARY="CF-1.0";
LICENSE='No restrictions';

#=============
#  SUGGESTED 
#=============
CONTRIBUTOR_NAME="Matt Stumbaugh"
CONTRIBUTOR_ROLE=" "
CONTRIBUTOR_EMAIL=""
PUBLISHERNAME="Northwest Knowledge Network"
PUBLISHEREMAIL="info@northwestknowledge.net"
PUBLISHERURL="http://www.northwestknowledge.net"

DATE_MODIFIED=" - - ";
DATE_ISSUED=" - -";

GEOSPATIAL_LAT_UNITS="decimal degrees north";
GEOSPATIAL_LON_UNITS="decimal degrees east";
#GEOSPATIAL_LAT_RESOLUTION=0.0625 #hard coded below
#GEOSPATIAL_LON_RESOLUTION=0.0625 #hard coded below
GEOSPATIAL_VERTICAL_UNITS="None";
#GEOSPATIAL_VERTICAL_RESOLUTION=0 #hard coded below
GEOSPATIAL_VERTICAL_POSITIVE="Up";

#========================================================
#    PERFORM REPLACEMENTS USING NCL
#========================================================
MODELS=("bcc-csm1-1-m" "CanESM2" "CCSM4" "CNRM-CM5" "CSIRO-Mk3-6-0" "HadGEM2-ES365" "HadGEM2-CC365" "IPSL-CM5A-MR" "MIROC5" "NorESM1-M")

#GCMSOURCE="CMIP5: CCSM4 (University of Miami -RSMAS) global climate model, historical scenario, r6i1p1 ensemble run"
MODELNAME=(
"Beijing Climate Center, China Meteorological Administration"
"Canadian Centre for Climate Modelling and Analysis"
"University of Miami - RSMAS"
"Centre National de Recherches Meteorologiques /Centre Europeen de Recherche et Formation Avancees en Calcul Scientifique"
"Commonwealth Scientific and Industrial Research Organization in collaboration with Queensland Climate Change Centre of Excellence"
"Met Office Hadley Centre" 
"Met Office Hadley Centre" 
"Institute Pierre-Simon Laplace"
"Atmosphere and Ocean Research Institute (The University of Tokyo), National Institude for Environmental Studies, and Japan Agency for Marine-Earth Science and Technology"
"Norwegian Climate Centre"
)



$modelnum=0
for model in "${MODELS[@]}"
do
        cd "$model"
        $modelnum=$modelnum+1;
        $modelname=MODELNAME($modelnum)

	$runnum="1"
	if["$model" -eq "CCSM4"]
        then 
		$runnum="6"
	fi

        for i in *historical*.nc;do
                $scenname="historical"
                GCMSOURCE="CMIP5:{$model} ({$modelname}) global climate model, {$scenname} scenario, r{$runnum}i1p1 ensemble run"
                ncatted -O -h -a gcmsource,global,c,c,"$GCMSOURCE" $i
        done
        for i in *rcp45*.nc;do
                $scenname="RCP 4.5"
                GCMSOURCE="CMIP5:{$model} ({$modelname}) global climate model, {$scenname} scenario, r{$runnum}i1p1 ensemble run"
                ncatted -O -h -a gcmsource,global,c,c,"$GCMSOURCE" $i
        done
         for i in *rcp85*.nc;do
                $scenname="RCP 8.5"
                GCMSOURCE="CMIP5:{$model} ({$modelname}) global climate model, {$scenname} scenario, r{$runnum}i1p1 ensemble run"
                ncatted -O -h -a gcmsource,global,c,c,"$GCMSOURCE" $i
        done

        for i in *.nc;do
                echo $i
		#=============
		#  HIGHLY RECOMMENDED 
		#=============
                ncatted -O -h -a title,global,m,c,"$TITLE" $i
                ncatted -O -h -a summary,global,m,c,"$SUMMARY" $i
                #ncatted -O -h -a keywords,global,m,c,"$KEYWORDS" $i

		#=============
		#  RECOMMENDED 
		#=============
                ncatted -O -h -a id,global,m,c,"$ID" $i
                ncatted -O -h -a naming_authority,global,m,c,"$NAMINGAUTHORITY" $i
                #ncatted -O -h -a keywords_vocabulary,global,m,c,"$KEYWORDS_VOCABULARY" $i
                ncatted -O -h -a cdm_data_type,global,m,c,"$CDM_DATA_TYPE" $i
                #ncatted -O -h -a history,global,m,c,"$HISTORY" $i
                #ncatted -O -h -a comment,global,m,c,"$COMMENT" $i

                ncatted -O -h -a date_created,global,m,c,"$DATE_CREATED" $i
                ncatted -O -h -a creator_name,global,m,c,"$CREATOR_NAME" $i
                ncatted -O -h -a creator_url,global,m,c,"$CREATOR_URL" $i
                ncatted -O -h -a creator_role,global,m,c,"$CREATOR_ROLE" $i
                ncatted -O -h -a creator_email,global,m,c,"$CREATOR_EMAIL" $i
                #ncatted -O -h -a institution,global,m,c,"$INSTITUTION" $i
            
		#ncatted -O -h -a project,global,m,c,"$PROJECT" $i
                ncatted -O -h -a processing_level,global,m,c,"$PROCESSING_LEVEL" $i
                ncatted -O -h -a acknowledgment,global,m,c,"$ACKNOWLEDGMENT" $i

		#might need to hard code these values directly here
 		ncatted -O -h -a geospatial_lat_min,global,m,f,25.2 $i
                ncatted -O -h -a geospatial_lat_max,global,m,f,52.8 $i
                ncatted -O -h -a geospatial_lon_min,global,m,f,-67 $i
                ncatted -O -h -a geospatial_lon_max,global,m,f,-125 $i
                ncatted -O -h -a geospatial_vertical_min,global,m,f,0 $i
                ncatted -O -h -a geospatial_vertical_max,global,m,f,0 $i

  		ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
  		ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
                ncatted -O -h -a time_coverage_resolution,global,m,c,"$TIME_COVERAGE_RESOLUTION" $i

                ncatted -O -h -a standard_name_vocabulary,global,m,c,"$STANDARD_NAME_VOCABULARY" $i
                ncatted -O -h -a license,global,m,c,"$LICENSE" $i

		#=============
		#   SUGGESTED
		#=============
                ncatted -O -h -a contributor_name,global,m,c,"$CONTRIBUTOR_NAME" $i
                ncatted -O -h -a contributor_role,global,m,c,"$CONTRIBUTOR_ROLE" $i
                ncatted -O -h -a contributor_email,global,m,c,"$CONTRIBUTOR_EMAIL" $i

		ncatted -O -h -a publisher_name,global,m,c,"$PUBLISHERNAME" $i
                ncatted -O -h -a publisher_url,global,m,c,"$PUBLISHERURL" $i
                ncatted -O -h -a publisher_email,global,m,c,"$PUBLISHEREMAIL" $i

                ncatted -O -h -a date_modified,global,m,c,"$DATE_MODIFIED" $i
                ncatted -O -h -a date_issued,global,m,c,"$DATE_ISSUED" $i

                ncatted -O -h -a geospatial_lat_units,global,m,c,"$GEOSPATIAL_LAT_UNITS" $i
                ncatted -O -h -a geospatial_lat_resolution,global,m,f, 0.0625 $i
                ncatted -O -h -a geospatial_lon_units,global,m,c,"$GEOSPATIAL_LON_UNITS" $i
                ncatted -O -h -a geospatial_lon_resolution,global,m,f, 0.0625 $i
                ncatted -O -h -a geospatial_vertical_units,global,m,c,"$GEOSPATIAL_VERTICAL_UNITS" $i
                ncatted -O -h -a geospatial_vertical_resolution,global,m,f,0 $i
                ncatted -O -h -a geospatial_vertical_positive,global,m,c,"$GEOSPATIAL_VERTICAL_POSITIVE" $i
        done
        cd ../
done

