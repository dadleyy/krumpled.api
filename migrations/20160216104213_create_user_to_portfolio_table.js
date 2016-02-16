'use strict';

exports.up = function(knex, Promise) {
  return knex.schema.createTable("user_to_portfolio", function (table) {
    table.increments();
    table.integer("user");
    table.integer("portfolio");
    table.timestamps();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable("user_to_portfolio");
};
