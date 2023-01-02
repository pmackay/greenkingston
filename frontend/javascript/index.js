import "index.scss"
import "syntax-highlighting.css"
import Bulmatown from "bulmatown"
import {Timeline, DataSet } from 'vis-timeline/standalone'

// Import all JavaScript & CSS files from src/_components
import components from "bridgetownComponents/**/*.{js,jsx,js.rb,css}"

console.info("Bridgetown is loaded!")

var container = document.getElementById('timeline');

// Configuration for the Timeline
var options = {};

const groupMap = {
  'local': 1,
  'global': 2
}

var groups = new vis.DataSet([

  {
    id: 2,
    content: 'global'
  },
  {
    id: 1,
    content: 'local'
  }
]);

var timeline = new vis.Timeline(container, items, groups, options);
