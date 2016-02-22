"use strict";

exports.up = function(knex, Promise) {
  return knex.schema.createTable("symbol", function (table) {
    table.increments();
    table.string("full_name");
    table.string("symbol");
    table.timestamps();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable("symbol");
};
