'use strict';

exports.up = function(knex, Promise) {
  return knex.schema.table("symbol", function (table) {
    table.integer("exchange");
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.table("symbol", function (table) {
    table.dropColumn("exchange");
  });
};
