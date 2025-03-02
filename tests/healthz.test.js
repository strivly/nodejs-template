const request = require('supertest');
const app = require('../src/server'); // Import your Express app

describe('GET /healthz', () => {
  it('should return 200 and status: "ok"', async () => {
    const res = await request(app).get('/healthz');
    expect(res.status).toBe(200);
    expect(res.body).toEqual({ status: 'ok' });
  });
});
