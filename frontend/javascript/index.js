import "index.scss"
import "syntax-highlighting.css"
import Bulmatown from "bulmatown"

// Import all JavaScript & CSS files from src/_components
import components from "bridgetownComponents/**/*.{js,jsx,js.rb,css}"

console.info("Bridgetown is loaded!")

var container = document.getElementById('timeline');

// Configuration for the Timeline
var options = {
  template: function (item, element, data) {
    content = '<p>' + item.content + '</p>';
    if (item.image_url) {
      content = content + `<img src="${item.image_url}"/>`;
    }
    return content;
  }
};

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
