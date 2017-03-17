{GraphQLObjectType, GraphQLString, GraphQLList, GraphQLBoolean} = require 'graphql'


Train = new GraphQLObjectType({
  name: 'TrainType'
  fields:
    route: type: GraphQLString
    time: type: GraphQLString
})

MTASchedule = new GraphQLObjectType({
  name: 'MTASchedule'
  fields: =>
    schedule:
      type: new GraphQLList(Train)
      resolve: (obj) -> return obj.data[0].N

    routes:
      type:new GraphQLList(GraphQLString)
      resolve: (obj) ->
        return obj.data[0].routes

    updated:
      type: GraphQLString


})


module.exports = MTASchedule







