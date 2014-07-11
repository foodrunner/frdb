class Helper
  @hitByRaycast = (target, points) ->
    hit = false
    l = points.length
    i = 0
    j = l - 1
    x = target[0]
    y = target[1]
    while i < l
      pointi = points[i]
      pointj = points[j]
      hit = !hit if (pointi[1] >= y) != (pointj[1] >= y) and (x <= (pointj[0]-pointi[0])*(y-pointi[1])/(pointj[1]-pointi[1])+pointi[0])
      j = i
      i++
    hit

  @squaredDistanceBetween = (point1, point2) ->
    x = point1[0] - point2[0]
    y = point1[1] - point2[1]
    x * x + y * y

  @distanceBetween = (point1, point2) ->
    Math.sqrt(Helper.squaredDistanceBetween(point1, point2))

  @clone = (old) ->
    n = (if (old instanceof Array) then [] else {})
    for i, v of old
      n[i] = if typeof v is "object" then @clone(v) else v
    return n

module.exports = Helper