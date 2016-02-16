'use strict';

exports.up = function(knex, Promise) {
  return knex.schema.createTable("trade", function (table) {
    table.increments();
    table.decimal("cost");
    table.decimal("shares");
    table.integer("symbol");
    table.integer("portfolio");
    table.decimal("fee");
    table.timestamps();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable("trade");
};
