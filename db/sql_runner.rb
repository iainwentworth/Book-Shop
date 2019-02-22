require( 'pg' )

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'd3mi9m0aqf4tb2', host: 'ec2-107-21-99-237.compute-1.amazonaws.com', port:5432, user: 'aypycsdbmmmvri', password: '03c62efb5405232d1b93de2380410c557cb92f989b6c346e5bf5ad23dbb181be' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
