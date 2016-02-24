'use strict';

exports.up = function(knex, Promise) {
  return knex.schema.createTable("symbol_price_history", function (table) {
    table.increments();
    table.decimal("price");
    table.decimal("volume");
    table.timestamp("date");
    table.integer("symbol").unsigned().references("symbol.id");
    table.timestamps();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable("symbol_price_history");
};
