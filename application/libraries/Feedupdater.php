<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Feedupdater {

	public $CI;

	public function __construct()
    {
        
    	$this->CI =& get_instance();
		$this->CI->load->model('programs', '', TRUE);
		$this->CI->load->model('channels', '', TRUE);

    }

        public function updateFeed(){
        	$feedUrl = "http://xmltv.dtdns.net/alacarte/ddl?fichier=/xmltv_site/xmlPerso/gedeho.zip";
	        $currentFile = 'feeds/currentfeed.zip';
	        $newFile = 'feeds/temp/currentfeed.zip';
	        $feed = 'feeds/';
	        $xmlFile = 'feeds/gedeho.xml';
	        
	        // ***TODO*** : check la date, si >1 jour, télécharger un nouveau :
	        // $t = date('Y-m-d H:i:s');
	        // print_r(date_parse($t));
	        // echo "<br/>";
	        // print_r(date_parse("2017-06-23 01:25:00"));



	        // download a newfeed.zip :
	        $this->downloadZipFile($feedUrl, $newFile);    
	        
	        if(file_exists($newFile)){
	            // unzip the xml file if necessary :
	            if (!file_exists($xmlFile)) $this->unZipFeed($newFile, $feed);            
	            // create a currentfeed.zip if necessary :
	            if (!file_exists($currentFile)) copy($newFile, $currentFile);
	            // check if an updated xml file is required :
	            if($this->isUpdatedFile($currentFile, $newFile)){
	            	// unlink($xmlFile);
	            	unlink($currentFile);
	            	copy($newFile, $currentFile);
	            	$this->unZipFeed($newFile, $feed);
	            } 
	            // delete newfeed.zip :
	            unlink($newFile);
	        }else{
	            echo "Aucun flux plus récent n'a pu être récupéré. Utilisation du flux le plus récent.<br/>";
	        }

	        // chargement du fichier xml en bdd :
	        if(file_exists($xmlFile)) $this->updateDatabase('feeds/gedeho.xml');  

	    	
        }

        private function updateDatabase(){
        	$xmlFile = 'feeds/gedeho.xml';
	        $xml = simplexml_load_file($xmlFile);
	        foreach ($xml->children() as $child)
	        {
	            if($child->getName() == "programme") $this->updatePrograms($child);
	            if($child->getName() == "channel") $this->updateChannels($child); 
	        }  
        }

        private function updatePrograms($node){

	    	$XMLprogramSubtitle = "sub-title";
	    	$XMLepisode = "episode-num";

	        $datas = array();

	        $d = date_create_from_format('YmdHis O', $node["start"]);
	        $d = date_format($d, 'Y-m-d H:i:s');

	        $f = date_create_from_format('YmdHis O', $node["stop"]);
	        $f = date_format($f, 'Y-m-d H:i:s');

	        $datas['start'] = $d;   
	        $datas['end'] = $f;
	        $datas['channelId'] = $node["channel"];
	        $datas['title'] = $node->title->__toString();
	        $datas['length'] = $node->length->__toString();
	        $datas['subtitle'] = $node->$XMLprogramSubtitle->__toString();
	        $datas['desc'] = $node->desc->__toString();
	        $datas['category'] = $node->category->__toString();
	        $datas['imgurl'] = $node->icon["src"];
	        $datas['rating'] = $node->rating->value->__toString();
	        $datas['episode'] = $node->$XMLepisode->__toString();
	        
	        $this->CI->programs->addPrograms($datas);

	    }

	    private function updateChannels($node){

	    	$XMLchannelIcon = "icon";
	        $XMLiconSrc = "src";
	        $XMLchannelName = "display-name";

	        $channelId = $node["id"];
	        $channelName = $node->$XMLchannelName->__toString();
	        $channelIcon = $node->$XMLchannelIcon->attributes()->$XMLiconSrc;
	        $channelIcon = str_replace("http://localhost", "img", $channelIcon);
	        
	        $this->CI->channels->updateChannels($channelId, $channelIcon, $channelName);
	    }

	    private function downloadZipFile($url, $zipFile)
	    {    
	        $zipResource = fopen($zipFile, "w");
	        // Get The Zip File From Server
	        $ch = curl_init();
	        curl_setopt($ch, CURLOPT_URL, $url);
	        curl_setopt($ch, CURLOPT_FAILONERROR, true);
	        curl_setopt($ch, CURLOPT_HEADER, 0);
	        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	        curl_setopt($ch, CURLOPT_AUTOREFERER, true);
	        curl_setopt($ch, CURLOPT_BINARYTRANSFER,true);
	        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
	        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
	        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0); 
	        curl_setopt($ch, CURLOPT_FILE, $zipResource);
	        $page = curl_exec($ch);
	        if(!$page) {
	         echo "Error :- ".curl_error($ch);
	        }
	        curl_close($ch);
	    }

	    private function isUpdatedFile($a, $b){
	        // echo (md5_file($a) ."---". md5_file($b));
	        return !(md5_file($a) == md5_file($b));
	    }

	    private function unZipFeed($currentFile, $feed){
	        $zip = new ZipArchive;        
	        $extractPath = $currentFile;
	        if($zip->open($currentFile) != "true"){
	         echo "Error :- Unable to open the Zip File";
	        } 
	        /* Extract Zip File */
	        $zip->extractTo($feed);
	        $zip->close();	        
	    }

}