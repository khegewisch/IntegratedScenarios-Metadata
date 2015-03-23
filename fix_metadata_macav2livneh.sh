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
TITLE="MACAv2-LIVNEH statistically downscaled climate simulations using CMIP5 forcings over the contiguous USA.";  #describes project
SUMMARY="This archive contains daily timestep and 1/16-deg resolution meteorological outputs for the contiguous United States produced by MACAv2-LIVNEH(Multivariate Adaptive Constructed Analogs) statistical downscaling method by Abatzoglou, Brown, 2011 performed on daily outputs from global climate model simulations of the the historical (1950-2005) and future RCP4.5/8.5 (2006-2099) scenarios from Phase 5 of the Coupled Model Intercomparison Project (CMIP5) utilizing the Livneh et al (2013) training dataset.  Leap days have been added to the dataset from the average values between Feb 28 and Mar 1 in order to aid modellers.";
KEYWORDS="MACA,CMIP5,METDATA,maximum temperature,minimum temperature, precipitation amount, downward shortwave solar radiation, wind speed, specific humidity";

#=============
#  RECOMMENDED 
#=============
ID="Blank";  #leave blank, NKN will have to fix later
NAMINGAUTHORITY="edu.uidaho.nkn"
KEYWORDS_VOCABULARY="None"
CDM_DATA_TYPE="GRID";
HISTORY="Created by Katherine Hegewisch,University of Idaho, Department of Geography, Applied Climate Science Lab.Revision 1: The leap years in the previous version were corrected, as they had been set to the first year in each datafile erroneously upon making the netcdf files."
#COMMENT="Daily outputs of the MACA downscaling of daily outputs from r1i1p1 ensemble, CCSM4 GCM (from University of Miami - RSMAS). The projection information for this file is GCS WGS 1984."   #probably we should agree to add the crs variable to give projection


DATE_CREATED="2014-02-01"
CREATOR_NAME="John Abatzoglou";
CREATOR_URL="http://climate.nkn.uidaho.edu/MACA/"
CREATOR_ROLE="Principal Investigator";
CREATOR_EMAIL="jabatzoglou@uidaho.edu";
#INSTITUTION="University of Idaho";
#PROJECT="Integrated Scenarios Project of the Northwest Climate Sciences Center"
PROCESSING_LEVEL="Gridded Climate Projections";
ACKNOWLEDGMENT="Please reference the Northwest Climate Science Center (NW CSC) US Geological Survey Grant Number G11AC20256 and the references included herein. We acknowledge the World Climate Research Programme's Working Group on Coupled Modelling, which is responsible for CMIP, and we thank the climate modeling groups for producing and making available their model output. For CMIP the U.S. Department of Energy's Program for Climate Model Diagnosis and Intercomparison provides coordinating support and led development of software infrastructure in partnership with the Global Organization for Earth System Science Portals.";

#hard coded down below
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
#LICENSE='No restrictions';
LICENSE="Creative Commons CC0 1.0 Universal Dedication(http://creativecommons.org/publicdomain/zero/1.0/legalcode)";
#LICENSE URI='http://creativecommons.org/publicdomain/zero/1.0/legalcode'

#=============
#  SUGGESTED 
#=============
CONTRIBUTOR_NAME="Katherine Hegewisch";
CONTRIBUTOR_ROLE="Postdoctoral Fellow";
CONTRIBUTOR_EMAIL="khegewisch@uidaho.edu";
PUBLISHERNAME="Northwest Knowledge Network"
PUBLISHEREMAIL="info@northwestknowledge.net"
PUBLISHERURL="http://www.northwestknowledge.net"

DATE_MODIFIED="2014-09-22";
DATE_ISSUED="2014-09-22";

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
MODELS=("CNRM-CM5" "CSIRO-Mk3-6-0" "inmcm4" "MIROC5" "bcc-csm1-1" "GFDL-ESM2G" "GFDL-ESM2M" "HadGEM2-ES365" "bcc-csm1-1-m" "BNU-ESM" "NorESM1-M" "MRI-CGCM3" "CCSM4" "MIROC-ESM" "IPSL-CM5B-LR" "MIROC-ESM-CHEM" "HadGEM2-CC365" "CanESM2" "IPSL-CM5A-MR" "IPSL-CM5A-LR")

for model in "${MODELS[@]}"
do
        cd "$model" 

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

