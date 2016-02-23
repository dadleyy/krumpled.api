'use strict';

exports.up = function(knex, Promise) {
  return knex.schema.table("trade", function (table) {
    table.renameColumn("cost", "price_per_share");
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.table("trade", function (table) {
    table.renameColumn("price_per_share", "cost");
  });
};
