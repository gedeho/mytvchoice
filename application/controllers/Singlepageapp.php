<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * CI Smarty
 *
 * Smarty templating for Codeigniter
 *
 * @package   CI Smarty
 * @author    Dwayne Charrington
 * @copyright 2015 Dwayne Charrington and Github contributors
 * @link      http://ilikekillnerds.com
 * @license   MIT
 * @version   3.0
 */

class Singlepageapp extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->model('channels', '', TRUE);
        $this->load->model('programs', '', TRUE);
        $this->config->load('gedeho');
    }

    public function index(){
        $channelsList = $this->input->cookie('channelselection');
        $channelselection = $this->getUserSelection($channelsList);
        $results = $this->programs->getCurrent($channelselection);
        $data['programs'] = $results;
        $data['title'] = "Programmes TV du ".date("d-m-Y");
        $data['channels'] = $this->channels->getChannels();
        $this->parser->parse("programmes/singlepage.tpl", $data);   
    }

    public function updateFeed(){
        $this->load->library('feedupdater');
        $this->feedupdater->updateFeed();
        redirect('programmestv/getCurrent');
    }

    public function refresh(){
        $selection = $this->input->get('channels');
        $programs = $this->programs->getCurrent($selection);
        $this->output->set_content_type('application/json');
        echo json_encode($programs);
    }

    public function getCurrent(){
        $channelsList = $this->input->cookie('channelselection');
        $channelselection = $this->getUserSelection($channelsList);
        $results = $this->programs->getCurrent($channelselection);
        $data['programs'] = $results;
        $data['channels'] = $this->channels->getChannels();
        $data['title'] = "Programmes TV du".date("l");
        $this->parser->parse("programmes/programmeslive.tpl", $data);      	
    }

    public function getEveningPrograms(){
        $channelsList = $this->input->cookie('channelselection'); 
        $channelselection = $this->getUserSelection($channelsList);
        $creneau = $this->input->get('creneau');
        $startA = $this->config->item('eveningStart'.$creneau);
        $startB = $this->config->item('eveningEnd'.$creneau);
        $programs = $this->programs->getRange($startA, $startB, $channelselection);
        $this->output->set_content_type('application/json');
        echo json_encode($programs);
    }

    public function getSoonFinished(){
        $finishIn = $this->input->get('a');
        $programs = $this->programs->getSoonFinished($finishIn);
        $this->output->set_content_type('application/json');
        echo json_encode($programs);
    }

    public function getSoonStarted(){
        $startIn = $this->input->get('a');
        $programs = $this->programs->getSoonStarted($startIn);
        $this->output->set_content_type('application/json');
        echo json_encode($programs);
    }

    private function getUserSelection($channelsList){               
        if($channelsList && count($channelsList)> 0){
            $channelselection = json_decode($this->input->cookie('channelselection'));
        }
        else{
            $channelselection = array("2", "3", "13", "5", "6", "1");
        }        
        return $channelselection;
    }    
}