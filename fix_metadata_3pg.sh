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


#Questions: 
#time.standardname
#time.longname

#========================================================
#    REPLACEMENTS
#========================================================
TITLE="3PG (version 3) vegetation simulations using MACAv1-METDATA CMIP5 forcings over the western USA.';
SUMMARY='This archive contains vegetation variables at a decadal timestep and 1/24-degree resolution for the western United States produced with the 3-PG (Physiological Principles for Predicting Growth) vegetation model. 3-PG is a process model that employs a light-use-efficiency based photosynthesis algorithm to simulate the change in net primary production over forest succession.  Monthly weather data is used to constrain photosynthesis based on high daytime atmospheric vapor pressure deficit, subfreezing temperatures, suboptimal temperatures, and soil water deficits.  A 3-PG model run (e.g. Coops et al. 2010) consists of a 50-year simulation of forest succession using a decade of climate data that is recycled five times. The simulations were forced with statistically downscaled global climate model (GCM) simulations using the method of Multivariate Adaptive Constructed Analogs (MACAv1-METDATA; Abatzoglou and Brown 2012) and trained to METDATA (Abatzoglou 2012) gridded surface observations.  Six downscaled meteorological variables were used at a monthly timestep: (1) average of daily minimum temperature and (2) daily maximum temperature, (3) precipitation, (4) downward solar radiation, (5) wind velocity, and (6) specific humidity. The downscaled forcings were constructed using 365-day global climate model (GCM) outputs from the Coupled Model Intercomparison Project Phase (CMIP5). Archived output data are the potential leaf area index (LAI), wood mass (WS), and net primary production (NPP) of a 50-year old conifer forest for each decade from the 1950s to the 2090s.";
KEYWORDS="Vegetation, 3PG, MACA statistical downscaling, CMIP5, Net Primary Production, NPP, Woody Stem Mass, Leaf Area Index, LAI";

#=============
#  RECOMMENDED 
#=============
ID='Blank';  #leave blank, NKN will have to fix later
NAMINGAUTHORITY="edu.uidaho.nkn"
KEYWORDS_VOCABULARY="None"
CDM_DATA_TYPE='GRID';
HISTORY="Created by Darrin Sharpe, Oregon State University, Oregon Climate Change Research Institute";
#would need to run over the models and enter the right info here
#COMMENT="Daily output of 3-PG simulation for historical scenario, r1i1p1 ensemble, CCSM4 GCM (from University of Miami - RSMAS). The projection information for this file is GCS WGS 1984."   #probably we should agree to add the crs variable to give projection

DATE_CREATED="2014-08-06"
CREATOR_NAME='David Turner';
CREATOR_URL='http://www.occri.edu'
CREATOR_ROLE='Principal Investigator';
CREATOR_EMAIL='david.turner@oregonstate.edu';
INSTITUTION="Oregon State University";
PROJECT="Integrated Scenarios Project of the Northwest Climate Sciences Center"
PROCESSING_LEVEL='Gridded Vegetation Projections';
ACKNOWLEDGMENT="Please reference the Northwest Climate Science Center (NW CSC) US Geological Survey Grant Number G12AC20495 and the references included herein. We acknowledge the World Climate Research Programme's Working Group on Coupled Modeling, which is responsible for CMIP, and we thank the climate modeling groups for producing and making available their model output. For CMIP, the U.S. Department of Energy's Program for Climate Model Diagnosis and Intercomparison provides coordinating support and led development of software infrastructure in partnership with the Global Organization for Earth System Science Portals.";

#hard coded down below
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

DATE_MODIFIED='2014-08-06'
DATE_ISSUED='2014-08-06'

GEOSPATIAL_LAT_UNITS='decimal degrees north'
GEOSPATIAL_LON_UNITS='decimal degrees east'
#GEOSPATIAL_LAT_RESOLUTION=0.0417000018060207 #hard coded below
#GEOSPATIAL_LON_RESOLUTION=0.0417000018060207 #hard coded below
GEOSPATIAL_VERTICAL_UNITS='None'
#GEOSPATIAL_VERTICAL_RESOLUTION=0  #hard coded below
GEOSPATIAL_VERTICAL_POSITIVE='Up'

#========================================================
#    PERFORM REPLACEMENTS USING NCL
#========================================================
MODELS=("GFDL-ESM2M" "HadGEM2-ES" "MIROC5")
#GCMSOURCE="CMIP5: CCSM4 (University of Miami -RSMAS) global climate model, historical scenario, r6i1p1 ensemble run"
MODELNAME=("NOAA Geophysical Fluid Dynamics Laboratory" "Met Office Hadley Centre" "Atmosphere and Ocean Research Institute (The University of Tokyo), National Institude for Environmental Studies, and Japan Agency for Marine-Earth Science and Technology")
$modelnum=0
for model in "${MODELS[@]}"
do
        cd "$model"
        $modelnum=$modelnum+1;
        $modelname=MODELNAME($modelnum)
	$runnum="1"

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
                ncatted -O -h -a title,global,c,c,"$TITLE" $i
                ncatted -O -h -a summary,global,c,c,"$SUMMARY" $i
                ncatted -O -h -a keywords,global,c,c,"$KEYWORDS" $i

		#=============
		#  RECOMMENDED 
		#=============
                ncatted -O -h -a id,global,c,c,"$ID" $i
                ncatted -O -h -a naming_authority,global,c,c,"$NAMINGAUTHORITY" $i
                #ncatted -O -h -a keywords_vocabulary,global,c,c,"$KEYWORDS_VOCABULARY" $i
                ncatted -O -h -a cdm_data_type,global,c,c,"$CDM_DATA_TYPE" $i
                #ncatted -O -h -a history,global,c,c,"$HISTORY" $i
                #ncatted -O -h -a comment,global,c,c,"$COMMENT" $i

                ncatted -O -h -a date_created,global,c,c,"$DATE_CREATED" $i
                ncatted -O -h -a creator_name,global,c,c,"$CREATOR_NAME" $i
                ncatted -O -h -a creator_url,global,c,c,"$CREATOR_URL" $i
                ncatted -O -h -a creator_role,global,c,c,"$CREATOR_ROLE" $i
                ncatted -O -h -a creator_email,global,c,c,"$CREATOR_EMAIL" $i
                #ncatted -O -h -a institution,global,c,c,"$INSTITUTION" $i
            
		#ncatted -O -h -a project,global,c,c,"$PROJECT" $i
                ncatted -O -h -a processing_level,global,c,c,"$PROCESSING_LEVEL" $i
                ncatted -O -h -a acknowledgment,global,c,c,"$ACKNOWLEDGMENT" $i

		#might need to hard code these values directly here
 		ncatted -O -h -a geospatial_lat_min,global,m,f,31 $i
                ncatted -O -h -a geospatial_lat_max,global,m,f,49.4 $i
                ncatted -O -h -a geospatial_lon_min,global,m,f,-103 $i
                ncatted -O -h -a geospatial_lon_max,global,m,f,-125 $i
                ncatted -O -h -a geospatial_vertical_min,global,m,f,0 $i
                ncatted -O -h -a geospatial_vertical_max,global,m,f,0 $i

  		ncatted -O -h -a time_coverage_start,global,c,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,c,c,"$TIME_COVERAGE_END" $i
  		ncatted -O -h -a time_coverage_duration,global,c,c,"$TIME_COVERAGE_DURATION" $i
                ncatted -O -h -a time_coverage_resolution,global,c,c,"$TIME_COVERAGE_RESOLUTION" $i


                ncatted -O -h -a standard_name_vocabulary,global,c,c,"$STANDARD_NAME_VOCABULARY" $i
                ncatted -O -h -a license,global,c,c,"$LICENSE" $i

		#=============
		#   SUGGESTED
		#=============
                ncatted -O -h -a contributor_name,global,c,c,"$CONTRIBUTOR_NAME" $i
                ncatted -O -h -a contributor_role,global,c,c,"$CONTRIBUTOR_ROLE" $i
                ncatted -O -h -a contributor_email,global,c,c,"$CONTRIBUTOR_EMAIL" $i

		ncatted -O -h -a publisher_name,global,c,c,"$PUBLISHERNAME" $i
                ncatted -O -h -a publisher_url,global,c,c,"$PUBLISHERURL" $i
                ncatted -O -h -a publisher_email,global,c,c,"$PUBLISHEREMAIL" $i

                ncatted -O -h -a date_modified,global,c,c,"$DATE_MODIFIED" $i
                ncatted -O -h -a date_issued,global,c,c,"$DATE_ISSUED" $i

                ncatted -O -h -a geospatial_lat_units,global,c,c,"$GEOSPATIAL_LAT_UNITS" $i
                ncatted -O -h -a geospatial_lat_resolution,global,m,f,0.0417000018060207 $i
                ncatted -O -h -a geospatial_lon_units,global,c,c,"$GEOSPATIAL_LON_UNITS" $i
                ncatted -O -h -a geospatial_lon_resolution,global,m,f,0.0417000018060207 $i
                ncatted -O -h -a geospatial_vertical_units,global,c,c,"$GEOSPATIAL_VERTICAL_UNITS" $i
                ncatted -O -h -a geospatial_vertical_resolution,global,c,f,0 $i
                ncatted -O -h -a geospatial_vertical_positive,global,c,c,"$GEOSPATIAL_VERTICAL_POSITIVE" $i
        done
        cd ../
done

