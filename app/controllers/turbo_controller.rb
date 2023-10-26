class TurboController < ApplicationController
  def index
    render json: {
      "settings": {
        "navbar": {
          "background": "#000000",
          "foreground": "#333333"
        },
        "tabbar": {
          "background": "#888888",
          "selected": "#ffffff",
          "unselected": "#bbbbbb"
        },
        "tabs": [
          {
            "title": "Home",
            "visit": "/",
            "icon_ios": "house",
            "protected": true
          },
         {
            "title": "Profile",
            "visit": "/me",
            "icon_ios": "person",
            "protected": true
          }
        ],
        "buttons": [
          {
            "path": "/",
            "side": "left",
            "icon_ios": "line.horizontal.3",
            "script": "window.bridge.showMenu();",
            "protected": false
          },
          {
            "path": "/",
            "side": "right",
            "title": "Add",
            "visit": "/posts/new",
            "protected": true
          }
        ]
      },
      "rules": [
        {
          "patterns": [
            "/new$",
            "/edit$"
          ],
          "properties": {
            "presentation": "modal"
          }
        },
        {
          "patterns": [
            "/users/login",
            "/users/signin",
            "/users/signup"
          ],
          "properties": {
            "presentation": "modal"
          }
        },
        {
          "patterns": [
            "/users/logout",
            "/users/signout",
            "/users/sign_out"
          ],
          "properties": {
            "presentation": "replace"
          }
        }
      ]
    }
    end 
end