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

class Programmestv extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->model('channels', '', TRUE);
        $this->load->model('programs', '', TRUE);
        $this->config->load('gedeho');
    }

    public function index(){
        echo "home";
    }

    public function updateFeed(){
        $this->load->library('feedupdater');
        $this->feedupdater->updateFeed();
        redirect('programmestv/getCurrent');
    }

    public function refresh(){
        $programs = $this->programs->getCurrent();
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
    

    public function getCurrent(){
        $results = $this->programs->getCurrent();
        $data['pageId'] = 0;
        $data['programs'] = $results;
        $data['title'] = "Programmes TV en cours de diffusion";
        $this->parser->parse("programmes/programmeslive.tpl", $data);      	
    }

    public function getPrograms($creneau=1){
        if($creneau <= 0 || $creneau > 2) redirect('programmestv/getCurrent');
        else
        {
            $data['pageId'] = $creneau;
            $startA = $this->config->item('eveningStart'.$creneau);
            $startB = $this->config->item('eveningEnd'.$creneau);
            $data['title'] = $this->config->item('eveningTitle'.$creneau);

            $data['programs'] = $this->programs->getRange($startA, $startB);
            $this->parser->parse("programmes/programmes.tpl", $data);
        }             
    }

    

    

    
}