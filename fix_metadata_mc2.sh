#!/bin/sh

#updates metadata in netcdfs according to suggestions at
#http://www.unidata.ucar.edu/software/thredds/current/netcdf-java/formats/DataDiscoveryAttConvention.html
#and consistent with other projects in Integrate Scenarios of Pacific Northwest


#Tim Sheehan - please modify all the entries with MC2 info... keeping as much as possible to the general format that is here from 3-PG

#========================================================
#    REPLACEMENTS
#========================================================
TITLE='3PG vegetation simulations using MACAv2-LIVNEH CMIP5 forcings over the western USA.';  #describes project
SUMMARY='This archive contains decadal timestep and 4-km resolution vegetation outputs for the western United States produced by 3-PG(Physiological Principles for Predicting Growth) vegetation simulations. The simulations were forced by Multivariate Adaptive Constructed Analogs (MACA, Abatzoglou, 2012) statistical downscaling of Global Climate Models and trained to METDATA (Abatzoglou, 2012) gridded surface observations.3-PG (Physiological Principles for Predicting Growth) is a process model that employs a light-use-efficiency based photosynthesis algorithm to simulate the change in net primary production over forest succession.  Monthly weather data is used to constrain photosynthesis based on high daytime atmospheric vapor pressure deficit, subfreezing temperatures, suboptimal temperatures, and soil water deficits.  Here we ran the model using climate output from the GFDL-ESM2M_rcp45 scenario associated with 5th IPCC Report.  The climate model data was downscaled to the 4 km resolution using the MACA (Multivariate Adapted Constructed Analogue) approach. A 3-PG model run (e.g. Coops et al. 2010) consists of a 50 year simulation of forest succession using a decade of climate data that is recycled five times. Thus we produced spatial output on the potential leaf area index(LAI), wood mass(WS), net primary production(NPP) of a 50 year old conifer forest for each decade from the 1950s to the 2090s. Results here are provisional and may be updated after publication.';
KEYWORDS='3PG,MACA,CMIP5,Net Primary Production, NPP,Woody Stem Mass, Leaf Area Index, LAI'; #variable in collection should be listed here

#=============
#  RECOMMENDED 
#=============
ID='';  #leave blank, NKN will have to fix later
NAMINGAUTHORITY="edu.uidaho.nkn"
#KEYWORDS_VOCABULARY="None"
CDM_DATA_TYPE='GRID';
HISTORY="Created by Darrin Sharpe,Oregon State Climate Research Institute"
#would need to run over the models and enter the right info here
#COMMENT="Daily output of 3-PG simulation for historical scenario, r1i1p1 ensemble, CCSM4 GCM (from University of Miami - RSMAS). The projection information for this file is GCS WGS 1984."   #probably we should agree to add the crs variable to give projection

DATE_CREATED="2014-08-06"
CREATOR_NAME='David Turner';
CREATOR_URL='http://www.occri.edu'
CREATOR_ROLE='Principal Investigator';
CREATOR_EMAIL='david.turner@oregonstate.edu';
#INSTITUTION="Oregon State University";
#PROJECT="Integrated Scenarios Project of the Northwest Climate Sciences Center"
PROCESSING_LEVEL='Gridded Vegetation Projections';
ACKNOWLEDGMENT="Please reference the Northwest Climate Science Center (NW CSC) US Geological Survey Grant Number G11AC20256 and the references included herein. We acknowledge the World Climate Research Programme's Working Group on Coupled Modelling, which is responsible for CMIP, and we thank the climate modeling groups for producing and making available their model output. For CMIP the U.S. Department of Energy's Program for Climate Model Diagnosis and Intercomparison provides coordinating support and led development of software infrastructure in partnership with the Global Organization for Earth System Science Portals.";

#GEOSPATIAL_LAT_MIN=31
#GEOSPATIAL_LAT_MAX=49.4
#GEOSPATIAL_LON_MIN=-103
#GEOSPATIAL_LON_MAX=-125
#GEOSPATIAL_VERTICAL_MIN=0
#GEOSPATIAL_VERTICAL_MAX=0

TIME_COVERAGE_START='1950-01-01T00:00';
TIME_COVERAGE_END='2099-12-31T00:00'
TIME_COVERAGE_DURATION='P150Y';
TIME_COVERAGE_RESOLUTION='P10Y';

STANDARD_NAME_VOCABULARY='CF-1.0';
LICENSE='No restrictions';

#=============
#  SUGGESTED 
#=============
CONTRIBUTOR_NAME='Darrin Sharpe';
CONTRIBUTOR_ROLE='Research Assistant';
CONTRIBUTOR_EMAIL='dsharp@coas.oregonstate.edu';
PUBLISHERNAME="Northwest Knowledge Network"
PUBLISHEREMAIL="info@northwestknowledge.net"
PUBLISHERURL="http://www.northwestknowledge.net"

DATE_MODIFIED ='2014-08-06'
DATE_ISSUED ='2014-08-06'

GEOSPATIAL_LAT_UNITS='decimal degrees north'
GEOSPATIAL_LON_UNITS='decimal degrees east'
GEOSPATIAL_LAT_RESOLUTION='Only applicable in rotated coordinates. See "geospatial comment".' #??????
GEOSPATIAL_LON_RESOLUTION='Only applicable in rotated coordinates. See "geospatial comment".' #??????
GEOSPATIAL_VERTICAL_UNITS='None'
GEOSPATIAL_VERTICAL_RESOLUTION='0'
GEOSPATIAL_VERTICAL_POSITIVE='Up'

#========================================================
#    PERFORM REPLACEMENTS USING NCL
#========================================================
MODELS=("GFDL-ESM2M" "HadGEM2-ES" "MIROC5")
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
 		ncatted -O -h -a geospatial_lat_min,global,m,f,GEOSPATIAL_LAT_MIN $i
                ncatted -O -h -a geospatial_lat_max,global,m,f,GEOSPATIAL_LAT_MAX $i
                ncatted -O -h -a geospatial_lon_min,global,m,f,GEOSPATIAL_LON_MIN $i
                ncatted -O -h -a geospatial_lon_max,global,m,f,GEOSPATIAL_LON_MAX $i
                ncatted -O -h -a geospatial_vertical_min,global,m,f,GEOSPATIAL_VERTICAL_MIN $i
                ncatted -O -h -a geospatial_vertical_max,global,m,f,GEOSPATIAL_VERTICAL_MAX $i

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

                ncatted -O -h -a geospatial_lat_units,global,m,f,GEOSPATIAL_LAT_UNITS $i
                ncatted -O -h -a geospatial_lat_resolution,global,m,f,GEOSPATIAL_LAT_RESOLUTION $i
                ncatted -O -h -a geospatial_lon_units,global,m,f,GEOSPATIAL_LON_UNITS $i
                ncatted -O -h -a geospatial_lon_resolution,global,m,f,GEOSPATIAL_LON_RESOLUTION $i
                ncatted -O -h -a geospatial_vertical_units,global,m,c,"$GEOSPATIAL_VERTICAL_UNITS" $i
                ncatted -O -h -a geospatial_vertical_resolution,global,m,c,"$GEOSPATIAL_VERTICAL_RESOLUTION" $i
                ncatted -O -h -a geospatial_vertical_positive,global,m,c,"$GEOSPATIAL_VERTICAL_POSITIVE" $i
        done
        cd ../
done

