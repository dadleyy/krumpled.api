'use strict';

exports.up = function(knex, Promise) {
  return knex.schema.createTable("trade", function (table) {
    table.increments();
    table.decimal("cost");
    table.decimal("shares");
    table.integer("symbol").unsigned().references("symbol.id");
    table.integer("portfolio").unsigned().references("portfolio.id");
    table.decimal("fee");
    table.timestamps();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable("trade");
};
