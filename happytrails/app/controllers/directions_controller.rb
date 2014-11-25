# @directions = response["routes"]["legs"]["steps"]

# i=0

# <table>
#   <tr>
#     <th>Step</th>
#     <th>Distance</th>
#     <th>Duration</th>
#     <th>Directions</th>
#   </tr>
# <% @directions.each do |stage| %?
#   <tr>
#     <td>i</td>
#     <td>distance=stage["distance"]["text"]</td>
#     <td>duration=stage["duration"]["text"]</td>
#     <td>directions=stage["html_instructions"].replaceAll("<[^>]*>", "")</td>
#   </tr>
# <% i = i+1 %>
# <%end%>
# </table>

class DirectionsController < ApplicationController


  def getdirections(startpoint_address, target_coordinates)

    origin = startpoint_address.gsub(/\s/,"+")

    packet = "origin=#{origin}&destination=#{target_coordinates}&units=imperial"

    response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?#{packet}")

    directions = response["routes"][0]["legs"][0]["steps"]

    directions_arr = []
    directions.each do |step|
      steps_arr = []
      steps_arr.push(step['distance']['text'])
      steps_arr.push(step['duration']['text'])
      instructions = step['html_instructions'].gsub(/<[^>]*>/,"")
      if instructions.match(/[a-z][A-Z]/) != nil
        match = instructions.match(/[a-z][A-Z]/).to_s
        match_alt = match[0] + "  " + match[1]
        instructions.gsub!(match,match_alt)
        steps_arr.push(instructions)
      else
        steps_arr.push(instructions)
      end

      directions_arr.push(steps_arr)
    end
    directions_arr
  end

  def index
    startpoint_address = params[:startpoint_address]
    trail = Trail.find(params[:trail_id])
    target_coordinates = trail.lat.to_s + "," + trail.lon.to_s
    directions = getdirections(startpoint_address, target_coordinates)
    respond_to do |format|
      format.html
      format.json {render :json => {directions: directions}}
    end
  end

end
