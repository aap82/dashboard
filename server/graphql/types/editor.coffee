{GraphQLObjectType, GraphQLString, GraphQLInt} = require 'graphql'
exports = module.exports



exports.dashboardEditorType = new GraphQLObjectType({
  name: 'DashboardEditorProps'
  fields:
    color: type: GraphQLString
    cardDepth: type: GraphQLInt
    backgroundAlpha: type: GraphQLInt
    backgroundColor: type: GraphQLString
    borderRadius: type: GraphQLInt
})

exports.DashboardEditorQueryFields = "
    color
    cardDepth
    backgroundColor
    backgroundAlpha
    borderRadius


"