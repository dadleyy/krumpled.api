module.exports = do ->

  copyable_definition_properties = [
    "type", "required", "unique",
    "collection", "via", "through", "model"
  ]

  copyBase = (attribute_definition) ->
    result = {}
    result[p] = attribute_definition[p] for p in copyable_definition_properties
    result

  ModelFactory = (attributes, table_name) ->

    Model =
      autoUpdatedAt: "updated_at"
      autoCreatedAt: "created_at"
      attributes: {}

    if table_name
      Model.tableName = table_name

    for field_name, definition of attributes
      Model.attributes[field_name] = copyBase definition

    Model.attributes.toJSON = () ->
      as_obj = @toObject()

      for field_name, definition of attributes
        delete as_obj[field_name] if definition.hidden == true

      as_obj

    Model


  ModelFactory
