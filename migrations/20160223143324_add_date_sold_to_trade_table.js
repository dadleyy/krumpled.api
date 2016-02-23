'use strict';

exports.up = function(knex, Promise) {
  return knex.schema.table("trade", function (table) {
    table.timestamp("date_sold").nullable();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.table("trade", function (table) {
    table.dropColumn("date_sold");
  });
};
